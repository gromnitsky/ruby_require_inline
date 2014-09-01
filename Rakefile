require "bundler/gem_tasks"
require "rake/testtask"

docs = FileList['*.md.m4'].sub(/\.md\.m4$/, '.md')

task :default => [:compile, :test]

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

task :compile => docs

rule '.md' => ['.md.m4'] do |t|
  sh "m4 #{t.source} > #{t.name}"
end
