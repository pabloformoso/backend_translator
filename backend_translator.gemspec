$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "backend_translator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "backend_translator"
  s.version     = BackendTranslator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jesus Miguel Sayar Celestino"]
  s.email       = ["xuxoceleste@gmail.com"]
  s.homepage    = "https://github.com/jesus-sayar/backend_translator"
  s.summary     = "Provides a web interface for manage Rails I18n texts, storing translations in a key-value store."
  s.description = "Provides a web interface for manage Rails I18n texts, storing translations in a key-value store."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency("rails", "~> 3.2.12")
  s.add_runtime_dependency("redis", "~> 3.0.2")
  s.add_runtime_dependency("sinatra", "~> 1.3.5")
  s.add_runtime_dependency("haml", "~> 4.0.0")

  s.add_development_dependency("capybara", "~> 2.0.2")
end
