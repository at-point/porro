require 'porro/types'

module Porro
  module Model
    module ClassMethods
      def attribute(name, type)
        type = Porro::Types.factory(type)
        porro_attributes << name.to_sym
        generate_porro_instance_accessors_for(name.to_sym, type)
      end

      def porro_attributes
        @porro_attributes ||= Set.new
      end

      def inherited(base)
        inherited_attrs = @porro_attributes ? @porro_attributes.dup : Set.new
        base.instance_variable_set(:'@porro_attributes', inherited_attrs)
      end

      private

      def porro_module
        @porro_module ||= Module.new.tap { |mod| include mod }
      end

      def generate_porro_instance_accessors_for(name, type)
        ivar = :"@#{name}"
        porro_module.module_eval do
          define_method("#{name}")  { instance_variable_get(ivar) }
          define_method("#{name}=") { |value| instance_variable_set(ivar, type.load(value)) }
          define_method("#{name}?") { send(name) }
        end
      end
    end

    def self.included(base)
      base.class_eval { extend ClassMethods }
    end

    def initialize(params = {})
      self.attributes = params
      super()
    end

    def attributes=(params = {})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end

    def attributes
      Hash[self.class.porro_attributes.map { |attr| [attr, send(attr)] }]
    end
  end
end
