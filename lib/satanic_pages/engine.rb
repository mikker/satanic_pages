module SatanicPages
  class Engine < ::Rails::Engine
    initializer("satanic_pages.view_helpers") do
      require_relative "../../app/helpers/satanic_pages/layout_helper"
      ActiveSupport.on_load(:action_view) { include SatanicPages::LayoutHelper }
    end

    initializer("satanic_pages.register_markdown") do
      if has_markdown_rails?
        require "satanic_pages/markdown_template_handler"

      end
    end

    private

    def has_markdown_rails?
      return true if defined?(MarkdownRails)

      require "markdown-rails"

      true
    rescue LoadError
      false
    end
  end
end
