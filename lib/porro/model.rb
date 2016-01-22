module Porro
  module Coders
    def self.factory(type)
      return StringCoder if [:str, :string].include?(type)
      return BooleanCoder if [:bool, :boolean].include?(type)
      return type if type.respond_to?(:load)
      NoneCoder
    end

    module AnyCoder
      def self.load(value); value end
    end

    module BooleanCoder
      def self.load(value)
        return false if %w{no false 0}.include?(value.to_s.downcase)
        !!value
      end
    end

    module StringCoder
      def self.load(str)
        str ? str.to_s : nil
      end
    end

    module NoneCoder
      def self.load(_); nil end
    end
  end

  module Model
    def attribute(attributes)
      attributes.each do |name, type|
        coder = Porro::Coders.factory(type)
        porro_attributes << name.to_sym
        generate_porro_instance_accessors_for(name.to_sym, coder)
      end
    end

    def porro_attributes
      @porro_attributes ||= Set.new
    end

    def inherited(base)
      base.instance_variable_set(:'@porro_attributes', @porro_attributes.dup)
    end

    private

    def porro_module
      @porro_module ||= Module.new.tap { |mod| include mod }
    end

    def generate_porro_instance_accessors_for(name, coder)
      ivar = :"@#{name}"
      porro_module.module_eval do
        define_method("#{name}")  { instance_variable_get(ivar) }
        define_method("#{name}=") { |value| instance_variable_set(ivar, coder.load(value)) }
        define_method("#{name}?") { send(name) }
      end
    end
  end
end
