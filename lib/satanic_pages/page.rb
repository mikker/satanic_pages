# frozen_string_literal: true

require "ostruct"

module SatanicPages
  class Page
    def initialize(full_path)
      @full_path = full_path
      @slug = nil
      @content = nil
      @data = nil
      parse!
    end

    attr_reader :slug, :full_path, :content, :data

    delegate_missing_to :data

    private

    def parse!
      @slug = File
        .basename(full_path)
        .gsub(/(\.\w+)+$/, "")

      @raw = File.read(full_path)

      @content = @raw.gsub(/\A---\n(.*?)\n---\n/m) do
        begin
          @data = OpenStruct.new(YAML.safe_load($1))
          nil
        rescue => e
          Rails.logger.error("Error parsing frontmatter: #{e.message}")
          @data = OpenStruct.new
          $&
        end
      end
    end
  end
end
