# frozen_string_literal: true

module SatanicPages
  class Railtie < ::Rails::Railtie
    initializer("satanic_pages.view_helpers") do
      ActiveSupport.on_load(:action_view) { include SatanicPages::LayoutHelper }
    end

    initializer("satanic_pages.register_markdown") do
      require "satanic_pages/markdown_template_handler"

    end
  end
end
