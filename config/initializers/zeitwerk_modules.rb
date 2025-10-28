# Configure Zeitwerk to understand the modular monolith structure under app/modules
# The layer directories (controllers, models, forms, services, serializers) are collapsed
# so that files under them contribute to the module namespace defined by the parent folders.
Rails.autoloaders.main.collapse(
  Dir[Rails.root.join('app/modules/*/{controllers,models,forms,services,serializers}')]
)
