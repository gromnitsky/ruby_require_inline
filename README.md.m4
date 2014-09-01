changequote([,])dnl
# ruby_require_inline

Recursively goes through ruby 'require' statements & prints a tree of
dependencies.

It does it by parsing .rb files, so it'll find only 'static'
declarations. Unfortunately, this won't be picked up:

    foo = 'bar'
    require foo

Only

    require 'bar'
    require './bar'
    require_relative '../bar'

& so on will work.

See https://github.com/gromnitsky/minirake as an example where it can be
useful.

## Installation

    gem install ruby_require_inline

## Usage

```
$ ruby_require_deps -h
syscmd([bin/ruby_require_deps -h])
```

Dump a tree:

```
$ ruby_require_deps ~/.rvm/src/ruby-2.0.0-p247/lib/irb.rb
/home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb.rb
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/e2mmap.rb
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/init.rb
    irb/error.rb (not local)
    /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/help.rb
      /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/magic-file.rb
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/context.rb
    /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/workspace.rb
      /home/alex/.rvm/src/ruby-2.0.0-p247/lib/tempfile.rb
        /home/alex/.rvm/src/ruby-2.0.0-p247/lib/delegate.rb
        /home/alex/.rvm/src/ruby-2.0.0-p247/lib/tmpdir.rb
          /home/alex/.rvm/src/ruby-2.0.0-p247/lib/fileutils.rb
            etc (not local)
          etc.so (not local)
        /home/alex/.rvm/src/ruby-2.0.0-p247/lib/thread.rb
    /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/inspector.rb
      /home/alex/.rvm/src/ruby-2.0.0-p247/lib/pp.rb
        /home/alex/.rvm/src/ruby-2.0.0-p247/lib/prettyprint.rb
      /home/alex/.rvm/src/ruby-2.0.0-p247/lib/yaml.rb
        psych (not local)
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/extend-command.rb
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/ruby-lex.rb
    /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/slex.rb
      /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/notifier.rb
        /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/output-method.rb
    /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/ruby-token.rb
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/input-method.rb
    /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/src_encoding.rb
    readline (not local)
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/locale.rb
    irb/encoding_aliases.rb (not local)
  /home/alex/.rvm/src/ruby-2.0.0-p247/lib/irb/version.rb
```

Use `-p` to add a relative path for additional deps search:


```
$ ruby_require_deps $GEM_HOME/gems/ruby_parser-3.6.2/bin/ruby_parse \
	-p $GEM_HOME/gems/ruby_parser-3.6.2/lib
/home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/bin/ruby_parse
  rubygems (not local?)
  /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby_parser.rb
    /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby18_parser.rb
      racc/parser.rb (not local?)
      /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby_lexer.rb
        /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby_lexer.rex.rb
          strscan (not local?)
      /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby_parser_extras.rb
        stringio (not local?)
        racc/parser (not local?)
        sexp (not local?)
        timeout (not local?)
    /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby19_parser.rb
    /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby20_parser.rb
    /home/alex/.rvm/gems/ruby-2.0.0-p247/gems/ruby_parser-3.6.2/lib/ruby21_parser.rb
  pp (not local?)
```

Generate 1 .rb file from all deps:

	$ ruby_require_deps ~/.rvm/src/ruby-2.0.0-p247/lib/irb.rb | \
		ruby_require_cat -o deps.rb

## License

MIT.
