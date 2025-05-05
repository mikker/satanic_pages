# frozen_string_literal: true

module SatanicPages
  class Frontmatter
    class MissingAttributeError < StandardError
    end

    def initialize(hash)
      @hash = (hash&.with_indifferent_access || {}).freeze
    end

    def to_h
      @hash
    end

    def method_missing(name, *args)
      if name.to_s.end_with?("!")
        attribute = name.to_s.chomp("!").to_sym

        unless @hash[attribute]
          raise MissingAttributeError, "Missing attribute: #{name.to_s.chomp("!")}"
        end

        @hash[attribute]

      elsif name.to_s.end_with?("?")
        @hash[name.to_s.chomp("?").to_sym].present?

      else
        @hash[name]
      end
    end

    def self.parse(source)
      frontmatter = nil

      rest = source.gsub(/\A---\n(.*?)\n---\n/m) do
        begin
          frontmatter = YAML.safe_load($1)
          ""
        rescue => e
          Rails.logger.error("Error parsing frontmatter: #{e.message}")
          $&
        end
      end

      [new(frontmatter), rest]
    end
  end
end
