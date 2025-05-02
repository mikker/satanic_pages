module SatanicPages
  class Engine < ::Rails::Engine
    initializer("satanic_pages.view_helpers") do
      require_relative "../../app/helpers/satanic_pages/layout_helper"
      ActiveSupport.on_load(:action_view) { include SatanicPages::LayoutHelper }
    end

    initializer("satanic_pages.register_markdown") do
      require "markdown-rails"
      require "satanic_pages/markdown_template_handler"

    end
  end
end
