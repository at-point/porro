require 'porro/types/string'

module Porro
  module Types
    module String
      def self.email
        Email
      end
    end

    module Email
      # See http://emailregex.com/
      EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

      def self.blankify
        self
      end

      def self.strip
        self
      end

      def self.default(value)
        self
      end

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
