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
          page = Page.new(full_path, base_path)
          hash[page.path] = page
        end
    end

    attr_reader :base_path, :pages

    def find(path)
      @pages.fetch(path)
    rescue KeyError
      raise PageNotFound, "No page `#{path}' found at #{base_path}"
    end

    def match?(req_path)
      path = req_path.gsub(/^\//, "")
      pages.keys.include?(path)
    end
  end
end
