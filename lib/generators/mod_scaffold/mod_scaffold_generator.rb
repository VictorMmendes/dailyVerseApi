# frozen_string_literal: true

require 'rails/generators'

module ModScaffold
  class ModScaffoldGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    class_option :context, type: :string, required: true, desc: 'Bounded context (e.g., knowledge)'
    class_option :slice, type: :string, required: true, desc: 'Vertical slice / module (e.g., books)'
    class_option :actions, type: :array, default: %w[index show create update destroy], desc: 'Controller actions to generate'
    class_option :attributes, type: :array, default: [], desc: 'Model attributes in Rails style (title:string published_on:date)'
    class_option :rbs, type: :boolean, default: true, desc: 'Generate RBS stubs'

    def normalize_arguments
      @context = options[:context].to_s.underscore
      @slice   = options[:slice].to_s.underscore
      @class_context = @context.camelize
      @class_slice   = @slice.camelize
      @resource_name = file_name.singularize
      @resource_class = @resource_name.camelize
      @attributes_array = (options[:attributes] || []).map do |pair|
        name, type = pair.split(':', 2)
        [name, (type || 'string')]
      end
    end

    def create_model
      template 'model.rb.tt', module_model_path
    end

    def create_form
      template 'form.rb.tt', module_form_path
    end

    def create_controller
      template 'controller.rb.tt', module_controller_path
    end

    def create_routes_file
      routes_path = File.join('app/modules', @context, @slice, 'config', 'routes.rb')
      unless File.exist?(routes_path)
        template 'routes.rb.tt', routes_path
      end
    end

    def create_rbs
      return unless options[:rbs]

      template 'model.rbs.tt', sig_model_path
      template 'form.rbs.tt', sig_form_path
      template 'controller.rbs.tt', sig_controller_path
    end

    private

    def module_base
      File.join('app/modules', @context, @slice)
    end

    def module_model_path
      File.join(module_base, 'models', "#{@resource_name}.rb")
    end

    def module_form_path
      File.join(module_base, 'forms', "#{@resource_name}_form.rb")
    end

    def module_controller_path
      File.join(module_base, 'controllers', "#{file_name.pluralize}_controller.rb")
    end

    def sig_root
      File.join('sig', 'app', 'modules', @context, @slice)
    end

    def sig_model_path
      File.join(sig_root, 'models', "#{@resource_name}.rbs")
    end

    def sig_form_path
      File.join(sig_root, 'forms', "#{@resource_name}_form.rbs")
    end

    def sig_controller_path
      File.join(sig_root, 'controllers', "#{file_name.pluralize}_controller.rbs")
    end

    # Expose for templates
    def attributes_kv
      @attributes_array
    end

    def actions
      Array(options[:actions])
    end
  end
end
