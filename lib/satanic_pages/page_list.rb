# frozen_string_literal: true

module SatanicPages
  class PageList
    class PageNotFound < StandardError
    end

    def initialize(ctrl)
      @base_path = Rails.root.join("app/views/", ctrl)

      @pages = Dir[base_path + "**/*.html*"]
        .reject { |path| path.match?(/(^_|\/_)/) }
        .each_with_object({}) do |full_path, hash|
          page = Page.new(full_path)
          hash[page.slug] = page
        end
    end

    attr_reader :base_path, :pages

    def find(slug)
      @pages.fetch(slug)
    rescue KeyError
      raise PageNotFound, "No page `#{slug}' found at #{base_path}"
    end

    def match?(path)
      path = path.gsub(/^\//, "")
      pages.keys.include?(path)
    end
  end
end
