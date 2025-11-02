# config/initializers/zeitwerk_modules.rb
Rails.autoloaders.main.collapse(
  Dir.glob(Rails.root.join("app/modules/**/{controllers,models,forms,commands,queries,services,serializers}")).reject do |path|
    layer_type = path.split("/").last
    explicit_module_layers = %w[forms commands queries services serializers]
    explicit_module_layers.include?(layer_type) && path.include?("/features/")
  end
)
