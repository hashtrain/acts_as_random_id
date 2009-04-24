require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

#require 'rubygems'
#Gem::manage_gems
#require 'rake/gempackagetask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the acts_as_random_id plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the acts_as_random_id plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActAsRandomId'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


PKG_FILES = FileList[
  '[a-zA-Z]*',
  'generators/**/*',
  'lib/**/*',
  'rails/**/*',
  'tasks/**/*',
  'test/**/*'
]

spec = Gem::Specification.new do |s| 
   s.name             = "acts_as_random_id" 
   s.version          = "0.0.1"
   s.author           = "hashtrain.com and author idea Stanislav Pogrebnyak"
   s.email            = "mail@hashtrain.com"
   s.homepage         = "http://hashtrain.com/"
   s.platform         = Gem::Platform::RUBY
   s.summary          = "Generate a random id for ActiveRecord models"
   s.files            = PKG_FILES.to_a
   s.require_path     = "lib"
   s.has_rdoc         = false
   s.extra_rdoc_files = ["README"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end 