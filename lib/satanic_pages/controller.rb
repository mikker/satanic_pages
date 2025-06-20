# frozen_string_literal: true

module SatanicPages
  module Controller
    extend ActiveSupport::Concern

    included do
      helper_method :data
    end

    class_methods do
      def constraint
        -> (req) { pages.match?(req.path) }
      end

      def pages
        @pages ||= PageList.new(controller_name)
      end
    end

    def show
      render_static_page
    end

    private

    def render_static_page
      # For nested pages, we need to render the template directly using its full path
      # Construct the template path based on the controller's view path and the page path
      template_path = "#{controller_path}/#{current_page.path}"
      render(template: template_path)
    end

    def current_page
      @page ||= self.class.pages.find(slug_param)
    end

    def slug_param
      params.require(:page)
    end

    def data
      current_page&.data
    end
  end
end
