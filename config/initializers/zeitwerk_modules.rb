# Configure Zeitwerk to understand the modular monolith structure under app/modules
# Collapse layer directories so modules like controllers/models/forms/commands/queries/services/serializers
# do not become part of the constant namespace (we use package-by-feature: Context::Slice::*).
Rails.autoloaders.main.collapse(
  Dir[Rails.root.join('app/modules/**/{controllers,models,forms,commands,queries,services,serializers}')]
)
