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

  def self.add_writer(klass, attribute, options)
    writer_name = "#{attribute}=".to_sym

    klass.instance_exec do
      define_method writer_name do |value|
        result_should_be_a_collection = options[:type].is_a?(Array)
        type = result_should_be_a_collection ? options[:type].first : options[:type]

        if type
          if result_should_be_a_collection
            value = [value].flatten(1).map do |element|
              element.is_a?(type) ? element : type.new(element)
            end
          else
            value = type.new(value) unless value.is_a?(type)
          end
        end

        instance_variable_set("@#{attribute}", value)
      end
    end

    writer_name
  end

  # class methods
  module ClassMethods
    def attribute(name, type = nil, options = {})
      if type.is_a?(Hash) && options.is_a?(Hash) && options.empty?
        options = type
      else
        options[:type] = type
      end

      class_variable_set(:@@mighty_attributes, {}) unless class_variable_defined?(:@@mighty_attributes)
      class_variable_get(:@@mighty_attributes)[name.to_s] = nil unless options[:serialize] == false

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

  # instance methods
  def attributes
    self.class.class_variable_defined?(:@@mighty_attributes) ? self.class.class_variable_get(:@@mighty_attributes) : {}
  end
end
