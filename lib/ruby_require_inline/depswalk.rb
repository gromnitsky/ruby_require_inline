module RubyRequireInline

  class DepsWalk

    def initialize entry_point
      @cache = {}
      @entry_point = entry_point
    end

    def start &block
      walk_deps @entry_point, &block
    end

    def walk_deps file, level = 0, stop = false, &block
      file = File.realpath file if level == 0
      return if @cache.key?(file)
      @cache[file] = true

      yield file, level, stop if block_given?
      return if stop

      sexp = RubyParser.new.parse IO.read(file)

      walk_sexp(sexp) do |node|
        dep = require_parse node
        if dep
          path = dep_path dep, file
          if path
            walk_deps path, level+1, false, &block # recursion!
          else
            # this will do &block and return
            walk_deps dep.first, level+1, true, &block # recursion!
          end
        end
      end
    end

    def walk_sexp sexp, &block
      sexp.sexp_body.each do |node|
        yield node if block_given?
        walk_sexp(node, &block) if node.is_a?(Sexp) # recursion!
      end
    end

    # Return a full path to a dependency, or nil if file not found. It
    # doesn't look in $LOAD_PATH.
    def dep_path dep, parent
      return nil unless dep

      [".rb", ""].each do |idx|
        file = dep.first + idx
        if dep[1]
          # dep.first is relative to a parent dep
          file = File.join File.dirname(parent), file
        end

        return File.realpath file if File.readable?(file) && File.file?(file)
      end

      #  puts "#{dep.first} not found"
      nil
    end

    # Return a 1st param of 'require' & relative flag or nil.
    #
    # Examples:
    #
    # ['foo', nil']
    # ['../bar, 'true']
    def require_parse sexp
      return nil unless sexp

      # valid node example: s(:call, nil, :require, s(:str, "getoptlong"))
      is_require_node = -> (node) {
        return nil unless node.is_a? Sexp
        node.sexp_type == :call \
        && sexp.sexp_body[2] && sexp.sexp_body[2].sexp_type == :str \
        && (node.sexp_body[1] == :require || \
            node.sexp_body[1] == :require_relative || \
            node.sexp_body[1] == :load)
      }

      return nil unless is_require_node.call sexp

      is_relative = -> (node) {
        node.sexp_body[1] == :require_relative || node.sexp_body[2].match(/^(\.{1,2})?\//)
      }

      if sexp.sexp_body[2]
        return [sexp.sexp_body[2].sexp_body.first, is_relative.call(sexp)]
      end

      nil
    end

  end

end
