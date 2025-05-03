module SatanicPages
  module LayoutHelper
    # Thank you Sitepress for this lil' goodie
    # https://github.com/sitepress/sitepress/blob/738aae7eaef61b494ad90786bc9f796374088ee1/sitepress-server/rails/app/helpers/application_helper.rb#L18
    def render_layout(layout, **kwargs, &block)
      render(html: capture(&block), layout: "layouts/#{layout}", **kwargs)
    end
  end
end
