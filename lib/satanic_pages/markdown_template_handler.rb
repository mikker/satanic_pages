# frozen_string_literal: true

module SatanicPages
  class MarkdownTemplateHandler < MarkdownRails::Renderer::Rails
    include Redcarpet::Render::SmartyPants
    TEMPLATE_ANNOTATION_REGEX =
      /<!\p{Pd}{1,2}\s*(BEGIN|END)\s+.*?\s*\p{Pd}{1,2}>/m

    def preprocess(source)
      frontmatter, rest = Frontmatter.parse(source)

      render(inline: rest, handler: :erb, locals: {data: frontmatter})
        # Remove template comments (including SmartyPants converted dashes)
        .gsub(TEMPLATE_ANNOTATION_REGEX, "")
        # Force HTML tags to be inline
        .gsub(/<[^>]*?>/) { |tag| tag.gsub(/\n\s*/, " ") }
    end
  end
end

MarkdownRails.handle(:md) do
  SatanicPages::MarkdownTemplateHandler.new
end
