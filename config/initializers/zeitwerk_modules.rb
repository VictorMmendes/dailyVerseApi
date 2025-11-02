Rails.autoloaders.main.collapse(
  Dir.glob(Rails.root.join("app/modules/**/{controllers,models,forms,commands,queries,services,serializers}")).reject do |path|
    layer_type = path.split("/").last

    # Estes tipos de camada NÃO devem ser colapsados em NENHUM lugar
    # se a intenção é que se tornem módulos explícitos (ex: Knowledge::Books::Queries).
    explicit_module_layers = %w[forms commands queries services serializers]

    explicit_module_layers.include?(layer_type) # <--- Condição simplificada!
  end
)