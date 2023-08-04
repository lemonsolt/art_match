require "test_helper"

class Gallary::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gallary_searches_index_url
    assert_response :success
  end
end
