Gem::Specification.new do |s|

  s.name = %q{acts_as_random_id}
  s.version = "1.0.0"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["hashtrain.com", "Author idea Stanislav Pogrebnyak (stanislav.pogrebnyak@gmail.com)"]
  s.date    = %q{2009-04-25}
  s.email   = %q{mail@hashtrain.com}
  s.extra_rdoc_files = ["README"]
  s.files   = ["MIT-LICENSE", "Rakefile", "README", 'lib/acts_as_random_id.rb', 'test/acts_as_random_id_test.rb', 'test/schema.rb', 'test/test_helper.rb', 'test/database.yml']
  s.has_rdoc = true
  s.homepage = %q{http://github.com/hashtrain/acts_as_random_id}
  s.require_paths = ["lib"]
  s.summary = %q{Generate a random id for ActiveRecord models}

end