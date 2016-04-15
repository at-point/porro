module Porro
  class Compiler
    attr_reader :registry

    def initialize(registry)
      @registry = registry
    end

    def call(ast)
      visit(ast)
    end

    def visit(node, *args)
      #puts "visit(#{node.inspect}, #{args.inspect}) -> visit_#{node[0]}"
      send(:"visit_#{node[0]}", node[1], *args)
    end

    def visit_type(node)
      #puts "visit_type(#{node.inspect})"
      type, args = node
      meth = :"visit_#{type.tr('::', '_')}"

      if respond_to?(meth)
        send(meth, args)
      elsif registry.key?(type.to_sym)
        #puts "REGISTRY LOOKUP #{type.to_sym}"
        #puts "#{registry.inspect}"
        registry[type.to_sym]
      else
        #puts "!! CONSTANTIZE #{type}"
        constantize(type)
      end
    end

    def visit_blankify(node)
      Porro::Types::Blankify.new(visit(node))
    end

    def visit_strip(node)
      Porro::Types::Strip.new(visit(node))
    end

    def visit_collection(collection_type, node)
      # TBD
    end

    def visit_struct(node) # node = schema
      #puts "visit_struct #{node.inspect}"
      registry[:struct].new(
        node.map { |member| visit(member) }.reduce(:merge)
      )
    end

    def visit_member(node)
      name, types = node
      #puts "visit_member #{node.inspect} - name: #{name}, types: #{types.inspect}"
      { name.to_sym => visit(types) }
    end

    private

    def constantize(camel_cased_word)
      names = camel_cased_word.split('::'.freeze)

      # Trigger a built-in NameError exception including the ill-formed constant in the message.
      Object.const_get(camel_cased_word) if names.empty?

      # Remove the first blank element in case of '::ClassName' notation.
      names.shift if names.size > 1 && names.first.empty?

      names.inject(Object) do |constant, name|
        if constant == Object
          constant.const_get(name)
        else
          candidate = constant.const_get(name)
          next candidate if constant.const_defined?(name, false)
          next candidate unless Object.const_defined?(name)

          # Go down the ancestors to check if it is owned directly. The check
          # stops when we reach Object or the end of ancestors tree.
          constant = constant.ancestors.inject do |const, ancestor|
            break const    if ancestor == Object
            break ancestor if ancestor.const_defined?(name, false)
            const
          end

          # owner is in Object, so raise
          constant.const_get(name, false)
        end
      end
    end
  end
end
