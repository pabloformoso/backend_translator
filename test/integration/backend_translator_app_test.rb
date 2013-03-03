require 'test_helper'

class BackendTranslatorAppTest < ActiveSupport::IntegrationCase

	# Clean up store and load default translations after test
	teardown { BackendTranslator.reload! }

	test "can translate messages from a given locale to another" do
		assert_raise I18n::MissingTranslationData do
			I18n.l(Date.new(2012, 01, 15), locale: :pl)
		end

		visit "/translator/en/pl"
		fill_in "date.formats.default", with: %("%d-%m-%Y")
		click_button "Store translations"

		assert_match "Translations stored with success!", page.body
		assert_equal "15-01-2012", I18n.l(Date.new(2012, 01, 15), locale: :pl)

	end


end
