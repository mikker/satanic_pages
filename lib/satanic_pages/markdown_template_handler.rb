module SatanicPages
  class MarkdownTemplateHandler < MarkdownRails::Renderer::Rails
    def preprocess(source)
      frontmatter = {}

      content = source.gsub(/\A---\n(.*?)\n---\n/m) do
        begin
          frontmatter = YAML.safe_load($1)
          ""
        rescue => e
          Rails.logger.error("Error parsing frontmatter: #{e.message}")
          $&
        end
      end

      data = OpenStruct.new(frontmatter)

      render(inline: content, handler: :erb, locals: {current_page: data})
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
