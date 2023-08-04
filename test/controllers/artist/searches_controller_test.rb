require "test_helper"

class Artist::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_searches_index_url
    assert_response :success
  end
end
