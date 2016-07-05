require "mighty_attributes/version"

module MightyAttributes
  def self.included(base)
    base.extend(ClassMethods)
  end

  def self.add_reader(klass, attribute, options)
    reader_name = attribute.to_sym

    klass.instance_exec do
      define_method reader_name do
        instance_variable_name = "@#{attribute}".to_sym

        unless instance_variable_defined?(instance_variable_name)
          options[:default]
        else
          instance_variable_get(instance_variable_name)
        end
      end
    end

    reader_name
  end

  def self.add_writer(klass, attribute, _options)
    writer_name = "#{attribute}=".to_sym

    klass.instance_exec do
      define_method writer_name do |value|
        instance_variable_set("@#{attribute}", value)
      end
    end

    writer_name
  end

  module ClassMethods
    def attribute(name, type = nil, options = {})
      if type.is_a?(Hash) && options.is_a?(Hash) && options.empty?
        options = type
        type = nil # rubocop:disable Lint/UselessAssignment
      end

      [
        (MightyAttributes.add_reader(self, name, options) unless options[:reader] == false),
        (MightyAttributes.add_writer(self, name, options) unless options[:writer] == false)
      ]
    end

    private

    # pathch private to allow private attribute :foo, String
    def private(*method_names)
      super(*method_names.flatten)
    end
  end
end
