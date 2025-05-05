# frozen_string_literal: true

require "ostruct"

module SatanicPages
  class Frontmatter
    def initialize(source)
      @source = source
      @data = nil
      @rest = nil
      parse!
    end

    attr_reader :source, :data, :rest

    private

    def parse!
      frontmatter = nil

      @rest = source.gsub(/\A---\n(.*?)\n---\n/m) do
        begin
          frontmatter = YAML.safe_load($1)
          ""
        rescue => e
          Rails.logger.error("Error parsing frontmatter: #{e.message}")
          $&
        end
      end

      @data = OpenStruct.new(frontmatter)
    end
  end
end
