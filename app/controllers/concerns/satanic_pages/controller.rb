module SatanicPages
  module Controller
    extend ActiveSupport::Concern

    included do
      helper_method :current_page
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
      @test = "wut"
      render_static_page
    end

    private

    def slug_param
      params.require(:page)
    end

    def pages
      self.class.pages
    end

    def current_page
      pages.find(slug_param)
    end

    # Bit of a hack here. As Rails resolves the layout pretty late, there's no
    # public way of looking it up at this point.
    # We do however control the rendering, probably, so the only thing we check
    # for is if the controller class has called self.layout.
    def page_layout
      self.class._layout || "application"
    end

    def render_static_page
      render(current_page.slug)
    end
  end
end
