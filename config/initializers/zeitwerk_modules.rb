# config/initializers/zeitwerk_modules.rb

# ... (código existente descomentado)

# Adicionamos uma regra mais específica para colapsar pastas de 'ação' ou 'use case'
# que contêm comandos e forms.
Rails.autoloaders.main.collapse(
  # Colapsa as pastas de camada (controllers, models, forms, etc.)
  Dir.glob(Rails.root.join('app/modules/**/{controllers,models,forms,commands,queries,services,serializers}'))
)

# Adicional: Colapsamos pastas de ação/use case que possuem subpastas de camadas.
# Exemplo: knowledge/books/features/create
Rails.autoloaders.main.collapse(
  Dir.glob(Rails.root.join('app/modules/**/features/*'))
)