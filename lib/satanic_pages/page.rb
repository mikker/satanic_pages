# frozen_string_literal: true

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

    private

    def parse!
      @slug = File
        .basename(full_path)
        .gsub(/(\..+)+$/, "")

      rel_path = full_path.to_s.sub("#{@base_path}/", "")
      @path = rel_path.gsub(/(\..+)+$/, "")

      @raw = File.read(full_path)

      fm = Frontmatter.new(@raw)
      @content = fm.rest
      @data = fm.data
    end
  end
end
