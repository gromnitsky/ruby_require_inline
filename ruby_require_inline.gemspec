# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_require_inline/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_require_inline"
  spec.version       = RubyRequireInline::VERSION
  spec.authors       = ["Alexander Gromnitsky"]
  spec.email         = ["alexander.gromnitsky@gmail.com"]
  spec.summary       = "Analyses all 'require' statements & concatenates dependencies into 1 file."
  spec.description   = "See the summary."
  spec.homepage      = "https://github.com/gromnitsky/ruby_require_inline"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "minitest", "~> 5.4.1"

  spec.add_dependency "ruby_parser", "~> 3.6.2"
end
