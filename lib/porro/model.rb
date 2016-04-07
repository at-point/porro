require 'porro/types'

module Porro
  module Model
    module ClassMethods
      def attribute(name, type, options = {})
        name = name.to_sym
        type = Porro::Types.factory(type, options)
        porro_attributes[name] = type
        generate_porro_instance_accessors_for(name, type)
      end

      def porro_attributes
        @porro_attributes ||= Hash.new
      end

      def inherited(base)
        inherited_attrs = @porro_attributes ? @porro_attributes.dup : Hash.new
        base.instance_variable_set(:'@porro_attributes', inherited_attrs)
      end

      private

      def porro_module
        @porro_module ||= Module.new.tap { |mod| include mod }
      end

      def generate_porro_instance_accessors_for(name, type)
        porro_module.module_eval do
          define_method("#{name}")  { read_porro_attribute_raw(name) }
          define_method("#{name}=") { |value| write_porro_attribute(name, value) }
          define_method("#{name}?") { send(name) }
        end
      end
    end

    def self.included(base)
      base.class_eval { extend ClassMethods }
    end

    def initialize(params = {})
      self.attributes = attributes.merge(params.to_h)
      super()
    end

    def attributes=(params = {})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params.respond_to?(:each)
    end

    def attributes
      Hash[self.class.porro_attributes.map { |attr, type| [attr, read_porro_attribute(attr)] }]
    end

    private

    def read_porro_attribute_raw(name)
      ivar = :"@#{name}"
      instance_variable_get(ivar) if instance_variable_defined?(ivar)
    end

    def read_porro_attribute(name)
      type = self.class.porro_attributes.fetch(name, Porro::Types::None)
      type.dump(read_porro_attribute_raw(name))
    end

    def write_porro_attribute(name, value)
      ivar = :"@#{name}"
      type = self.class.porro_attributes.fetch(name, Porro::Types::None)
      instance_variable_set(ivar, type.load(value))
    end
  end
end
