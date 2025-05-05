require "test_helper"

class SatanicPages::FrontmatterTest < ActiveSupport::TestCase
  test("it initializes with a hash of attributes") do
    frontmatter = SatanicPages::Frontmatter.new({title: "My Title"})
    assert_equal "My Title", frontmatter.title
  end

  test("freezes source hash") do
    frontmatter = SatanicPages::Frontmatter.new({title: "My Title"})
    assert frontmatter.to_h.frozen?
  end

  test("missing attributes return nil") do
    frontmatter = SatanicPages::Frontmatter.new({})
    assert_nil frontmatter.title
  end

  test("missing attributes with a bang raise an error") do
    frontmatter = SatanicPages::Frontmatter.new({})
    assert_raises(SatanicPages::Frontmatter::MissingAttributeError) { frontmatter.title! }
  end

  test("attributes with a question mark return true if the attribute is present") do
    frontmatter = SatanicPages::Frontmatter.new({title: "My Title"})
    assert frontmatter.title?
    refute frontmatter.author?
  end

  test("parse: it should parse frontmatter") do
    frontmatter, rest = SatanicPages::Frontmatter.parse("---\ntitle: My Title\n---\nHello, world!")

    assert_instance_of SatanicPages::Frontmatter, frontmatter
    assert_equal "My Title", frontmatter.title
    assert_equal "Hello, world!", rest
  end

  test("parse: it is empty if the frontmatter is unparseable and rest is original content") do
    source = "---\ntitle: My Title\n  hi: there---\nHello, world!"
    frontmatter, rest = SatanicPages::Frontmatter.parse(source)

    assert_instance_of SatanicPages::Frontmatter, frontmatter
    assert_equal({}, frontmatter.to_h)
    assert_equal source, rest
  end
end
