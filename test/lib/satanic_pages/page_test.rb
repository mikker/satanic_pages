require "test_helper"

module SatanicPages
  class PageTest < ActiveSupport::TestCase
    setup do
      @base_path = Rails.root.join("app/views/pages")
      @about_path = Rails.root.join("app/views/pages/about.html.md")
      @nested_path = Rails.root.join("app/views/pages/recipes/lemonade.html.md")
      @tmp_path = Rails.root.join("tmp")
    end

    test("parses a regular page correctly") do
      page = Page.new(@about_path, @base_path)

      assert_equal "about", page.slug
      assert_equal "about", page.path
      assert_equal @about_path, page.full_path
      assert page.content.present?
      assert_equal "About the Satanic Pages", page.data.title
    end

    test("parses a nested page correctly") do
      page = Page.new(@nested_path, @base_path)

      assert_equal "lemonade", page.slug
      assert_equal "recipes/lemonade", page.path
      assert_equal @nested_path, page.full_path
      assert page.content.present?
      assert_equal "Hellfire Lemonade", page.data.title
    end

    test("extracts frontmatter correctly") do
      page = Page.new(@nested_path, @base_path)

      assert_equal "Hellfire Lemonade", page.data.title
      assert_match "Quench Your Infernal Thirst", page.content
      assert_match "Hail Hydration!", page.content
    end

    test("handles missing frontmatter gracefully") do
      create_tempfile("test_page.html.md", "# Just content\nNo frontmatter here.") do |temp_file|
        page = Page.new(temp_file, @tmp_path)

        assert_equal "test_page", page.slug
        assert_equal "test_page", page.path
        assert_match "# Just content", page.content
        assert page.data.is_a?(OpenStruct), "Should initialize data as OpenStruct"
        assert_nil page.data.title
      end
    end

    test("handles different file extensions correctly") do
      create_tempfile("html_page.html", "---\ntitle: HTML Page\n---\n<h1>Hello HTML</h1>") do |temp_file|
        page = Page.new(temp_file, @tmp_path)

        assert_equal "html_page", page.slug
        assert_equal "html_page", page.path
        assert_match "<h1>Hello HTML</h1>", page.content
        assert_equal "HTML Page", page.data.title
      end
    end

    test("handles invalid YAML frontmatter gracefully") do
      content = <<-YAML
        ---
        title: 'Invalid: YAML'
          broken: indentation
        ---
        Content
      YAML
        .strip_heredoc

      create_tempfile("invalid_frontmatter.html.md", content) do |temp_file|
        page = Page.new(temp_file, @tmp_path)

        assert_equal "invalid_frontmatter", page.slug
        assert page.data.is_a?(OpenStruct), "Should initialize data as OpenStruct even with invalid YAML"
        # The entire frontmatter block should be included in content since parsing failed
        assert_match "---\ntitle: 'Invalid: YAML'\n  broken: indentation\n---", page.content
      end
    end

    test("handles deeply nested paths correctly") do
      content = <<-YAML
        ---
        title: Deep Page
        ---
        Deep content
      YAML
        .strip_heredoc

      FileUtils.mkdir_p(@tmp_path.join("deep/nested/structure"))

      create_tempfile("deep/nested/structure/deep_page.html.md", content) do |temp_file|
        page = Page.new(temp_file, @tmp_path)

        assert_equal "deep_page", page.slug
        assert_equal "deep/nested/structure/deep_page", page.path
        assert_match "Deep content", page.content
        assert_equal "Deep Page", page.data.title
      end
    end

    private

    def create_tempfile(path, content)
      full_path = @tmp_path.join(path)

      temp_file = File.open(full_path, "w") do |f|
        f.write(content)
      end

      yield(full_path) if block_given?
    ensure
      File.unlink(full_path) if File.exist?(full_path)
    end
  end
end
