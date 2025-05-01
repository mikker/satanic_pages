require "test_helper"

module SatanicPages
  class PageListTest < ActiveSupport::TestCase
    test("loads all pages including nested pages") do
      list = PageList.new("pages")
      assert_equal ["about", "recipes/lemonade"], list.pages.keys
      assert_equal [Page], list.pages.values.map(&:class).uniq
    end

    test("does lookups by find(path+basename)") do
      page = PageList.new("pages").find("about")
      assert_equal "about", page.slug
    end

    test("raises NotFound if not found") do
      assert_raises(PageList::PageNotFound) do
        PageList.new("pages").find("heaven")
      end
    end

    test("match? knows if a page exists") do
      list = PageList.new("pages")

      assert list.match?("about")
      assert list.match?("/about")
      assert list.match?("recipes/lemonade")

      refute list.match?("heaven")
      refute list.match?("heaven/is/a/place/on/earth")
    end
  end
end

