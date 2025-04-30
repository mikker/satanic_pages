require "test_helper"

class SatanicPagesTest < ActiveSupport::TestCase
  test("it has a version number") do
    assert SatanicPages::VERSION
  end
end
