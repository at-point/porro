require 'porro/types/base'

module Porro
  def self.string
    Types::String
  end

  module Types
    module String
      extend Base

      def self.email
        Email
      end

      def self.load(value)
        value.to_s
      end

      def self.dump(value)
        value.to_s
      end
    end

    module Email
      extend Base

      # See http://emailregex.com/
      EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

      def self.load(value)
        value = value.to_s.strip.downcase
        return value if value =~ EMAIL_REGEX
        nil
      end

      def self.dump(value)
        load(value)
      end
    end
  end
end
