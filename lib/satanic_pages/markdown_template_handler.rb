# frozen_string_literal: true

module SatanicPages
  class MarkdownTemplateHandler < MarkdownRails::Renderer::Rails
    def preprocess(source)
      frontmatter = Frontmatter.new(source)

      render(inline: frontmatter.rest, handler: :erb, locals: {data: frontmatter.data})
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
