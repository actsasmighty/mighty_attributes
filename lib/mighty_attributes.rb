require "mighty_attributes/version"

module MightyAttributes
  class MethodAlreadyDefinedError < StandardError; end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(name, type = nil, options = {})
      if type.is_a?(Hash) && options.is_a?(Hash) && options.empty?
        options = type
        type = nil
      end

      instance_variable_name = "@#{name}".to_sym
      method_names = []

      unless options[:reader] == false
        method_names << (reader_name = name.to_sym)

        if instance_methods.include?(reader_name) # rubocop:disable Style/GuardClause
          raise MethodAlreadyDefinedError.new("A method named #{reader_name} is already defined!")
        else
          define_method reader_name do
            instance_variable_get(instance_variable_name)
          end
        end
      end

      unless options[:writer] == false
        method_names << (writer_name = "#{name}=".to_sym)

        if instance_methods.include?(writer_name) # rubocop:disable Style/GuardClause
          raise MethodAlreadyDefinedError.new("A method named #{writer_name} is already defined!")
        else
          define_method writer_name do |value|
            instance_variable_set(instance_variable_name, value)
          end
        end
      end

      method_names
    end

    private

    # pathch private to allow private attribute :foo, String
    def private(*method_names)
      super(*method_names.flatten)
    end
  end
end
