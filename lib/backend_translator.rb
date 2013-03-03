require 'redis'

module BackendTranslator
	autoload :App, "backend_translator/app"

  DATABASES = {
    "development" => 0,
    "test" => 1,
    "production" => 2
  }

  def self.store
    @store ||= Redis.new(:db => DATABASES[Rails.env.to_s])
  end

  def self.reload!
    BackendTranslator.store.flushdb
    I18n.backend.load_translations
  end

  class Backend < I18n::Backend::KeyValue 
    include I18n::Backend::Memoize

    def initialize
      super(BackendTranslator.store)
    end
  end
end
