# frozen_string_literal: true

require "ostruct"

module SatanicPages
  class Page
    def initialize(full_path, base_path)
      @full_path = full_path
      @base_path = base_path
      @path = nil
      @slug = nil
      @content = nil
      @data = nil
      parse!
    end

    attr_reader :slug, :path, :full_path, :content, :data

    delegate_missing_to :data

    private

    def parse!
      @slug = File
        .basename(full_path)
        .gsub(/(\..+)+$/, "")

      rel_path = full_path.to_s.sub("#{@base_path}/", "")
      @path = rel_path.gsub(/(\..+)+$/, "")

      @raw = File.read(full_path)

      @content = @raw.gsub(/\A---\n(.*?)\n---\n/m) do
        begin
          @data = OpenStruct.new(YAML.safe_load($1))
          nil
        rescue => e
          Rails.logger.error("Error parsing frontmatter: #{e.message}")
          $&
        end
      end

      @data ||= OpenStruct.new
    end
  end
end
