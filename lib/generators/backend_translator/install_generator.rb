module BackendTranslator
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a BackendTranslator initializer and add routes to your routes.rb."

      def copy_initializer
        template "backend_translator.rb", "config/initializers/backend_translator.rb"
      end
 
      def add_route
        backend_translator_route  = "mount BackendTranslator::App, :at => \"/translator\""
        route backend_translator_route
      end
      
      #def copy_locale
       # copy_file "../../../config/locales/en.yml", "config/locales/backend_translator.en.yml"
      #end
    end
  end
end
