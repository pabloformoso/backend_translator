#---
# Excerpted from "Crafting Rails Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails for more book information.
#---
require 'sinatra/base'
require 'haml'

module BackendTranslator
  class App < Sinatra::Base
    set :environment, Rails.env
    enable :inline_templates

    #before do
     # env["warden"].authenticate!(:scope => "admin")
    #end

    get "/:from/:to" do |from, to|
      exhibit_translations(from, to)
    end

    post "/:from/:to" do |from, to|
      I18n.backend.store_translations to, decoded_translations, :escape => false
      BackendTranslator.store.save
      @message = "Translations stored with success!"
      exhibit_translations(from, to)
    end

    get "/:to" do |to|
    	new_translation(to)
    end

    post "/:to" do |to|
			I18n.backend.store_translations to, {params[:key] => params[:value]}, :escape => false
      BackendTranslator.store.save
      @message = "Added translations"
      new_translation(to)
    end

    protected

    # Get all translations sent through the form and decode
    # their JSON values to check validity.
    def decoded_translations
      translations = params.except("from", "to")
      translations.each do |key, value|
        translations[key] = ActiveSupport::JSON.decode(value) rescue nil
      end
    end

    # Store from and to locales in variables and retrieve
    # all keys available for translation.
    def exhibit_translations(from, to)
      @from, @to = from, to
      @keys = available_keys(from)
      haml :index
    end

    # Get all keys for a given locale removing the locale from
    # the key and sorting them alphabetically. If a key is named
    # "en.foo.bar", this method will return it as "foo.bar".
    def available_keys(locale)
      keys  = BackendTranslator.store.keys("#{locale}.*")
      range = Range.new(locale.size + 1, -1)
      keys.map { |k| k.slice(range) }.sort!
    end

    # Get the stored value in the translator store for a given
    # locale. This method needs to decode values and check if they
    # are a hash, because we don't want subtrees available for
    # translation since they are managed automatically by I18n.
    def locale_value(locale, key)
      value = BackendTranslator.store["#{locale}.#{key}"]
      value if value && !ActiveSupport::JSON.decode(value).is_a?(Hash)
    end

    def new_translation(to)
    	@to = to
    	haml :new
    end
  end
end

__END__

@@ index
!!!
%html
  %head
    %title
      BackendTranslator::App
  %body
    %h2= "From #{@from} to #{@to}"

    %p(style="color:green")= @message

    - if @keys.empty?
      No translations available for #{@from}
    - else
      %form(method="post" action="")
        - @keys.each do |key|
          - from_value = locale_value(@from, key)
          - next unless from_value
          - to_value = locale_value(@to, key) || from_value

          %p
            %label(for=key)
              %small= key
              = from_value
            %br
            %input(id=key name=key type="text" value=to_value size="120")

        %p
          %input(type="submit" value="Store translations")

@@ new
!!!
%html
	%head
		%title
			Translator::App
	%body
		%h2= "Create #{@to}"
		
		%p(style="color:green")= @message
		
		%form(method="post" action="")
			%label(for="key") CLAVE
			%br
			%input(id="key" name="key")
			%br
			%label(for="value") VALOR
			%br
			%input(id="value" name="value")
			%br
			%input(type="submit" value="Store translations")
