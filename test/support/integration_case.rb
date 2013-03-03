class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
	include Capybara::DSL
	include Rails.application.routes.url_helpers
	Capybara.app = Dummy::Application
end