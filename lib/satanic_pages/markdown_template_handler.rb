# frozen_string_literal: true

module SatanicPages
  class MarkdownTemplateHandler < MarkdownRails::Renderer::Rails
    include Redcarpet::Render::SmartyPants

    def preprocess(source)
      frontmatter, rest = Frontmatter.parse(source)

      render(inline: rest, handler: :erb, locals: {data: frontmatter})
        # Remove template comments
        .gsub(/<!-- (BEGIN|END) (.*) -->/, "")
        # Force HTML tags to be inline
        .gsub(/<[^>]*?>/) { |tag| tag.gsub(/\n\s*/, " ") }
    end
  end
end

MarkdownRails.handle(:md) do
  SatanicPages::MarkdownTemplateHandler.new
end
