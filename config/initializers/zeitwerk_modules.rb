# config/initializers/zeitwerk_modules.rb

# Configuração do Zeitwerk para módulos vertical slice em app/modules
# Importante: NÃO colapsar os diretórios de ação (features/*) para que
# constantes como Knowledge::Books::Features::Create existam e possam ser
# autoloadadas corretamente por Zeitwerk.

# Colapsa pastas de camada (controllers, models, forms, commands, queries, services, serializers)
# MAS somente se a pasta NÃO estiver aninhada diretamente sob um diretório 'features/'
# para os tipos de camada que devem ser módulos explícitos ali (forms, commands, etc.).
Rails.autoloaders.main.collapse(
  Dir.glob(Rails.root.join('app/modules/**/{controllers,models,forms,commands,queries,services,serializers}')).reject do |path|
    # Determina o tipo de pasta de camada (ex: 'forms', 'commands')
    layer_type = path.split('/').last

    # Estes tipos de camada NÃO devem ser colapsados se estiverem diretamente sob um diretório 'features/'.
    # Isso permite que se tornem módulos explícitos (ex: Knowledge::Books::Features::Create::Forms)
    explicit_module_layers = ['forms', 'commands', 'queries', 'services', 'serializers']

    explicit_module_layers.include?(layer_type) && path.include?('/features/')
  end
)