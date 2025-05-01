require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test("renders the about page") do
    get "/"

    assert_response :success
    assert_select "title", "About the Satanic Pages"
    assert_match "<p>Hi, my name is Lucifer</p>", response.body
    assert_match "<p>My sign is 🤘</p>", response.body
  end

  test("renders a specific page by path") do
    get "/about"
    assert_response :success
    assert_select "title", "About the Satanic Pages"
    assert_match "<p>Hi, my name is Lucifer</p>", response.body
    assert_match "<p>My sign is 🤘</p>", response.body
  end

  test("renders a nested page by path") do
    get "/recipes/lemonade"
    assert_response :success
    assert_select "title", "Hellfire Lemonade"
    assert_match "Quench Your Infernal Thirst", response.body
    assert_match "Hail Hydration! 🤘", response.body
  end

  test("renders 404 for non-existent page") do
    get "/non-existent-page"
    assert_match "Routing Error", response.body
  end
end
