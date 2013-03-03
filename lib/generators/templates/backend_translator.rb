#BackendTranslator.setup do |config|
#	# Update i18n backend of Rails
#	config.i18n.backend = BackendTranslator::Backend.new
#end
Rails.application.config.i18n.backend = BackendTranslator::Backend.new