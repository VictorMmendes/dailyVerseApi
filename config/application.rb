require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DailyVerseApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1
    config.api_only = true

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Add custom directories to auto-load/eager-load paths for modular monolith (DDD / Vertical Slice)
    # We use Zeitwerk collapse (see initializer) to ignore layer directories like controllers/models/forms.
    modules_root = Rails.root.join('app', 'modules').to_s
    config.autoload_paths << modules_root
    config.eager_load_paths << modules_root

    # Add the 'app/shared' directory to autoload paths
    shared_root = Rails.root.join('app', 'shared').to_s
    config.autoload_paths << shared_root
    config.eager_load_paths << shared_root

    # Generators configuration: API-only, no assets/helpers; use custom scaffold
    config.generators do |g|
      g.orm :active_record
      g.helper false
      g.assets false
      g.stylesheets false
      g.javascripts false
      g.test_framework :test_unit, fixture: false
      # register our custom generator namespace
      g.templates.unshift Rails.root.join('lib', 'generators', 'mod_scaffold', 'templates').to_s
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
