# ruby_require_inline

Recursively goes through ruby 'require' statements & prints a tree of
dependencies.

It does it by parsing .rb files, so it'll find only 'static'
declarations. This won't be picked up:

	foo = 'bar'
	require foo

Only

	require 'bar'
	require './bar'
	require_relative '../bar'

& so on will work.

## Installation

    gem install require_inline

## Usage

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

Generate 1 .rb file from all deps:

	$ ruby_require_deps ~/.rvm/src/ruby-2.0.0-p247/lib/irb.rb | \
		ruby_require_cat -o bundle.rb

## License

MIT.
