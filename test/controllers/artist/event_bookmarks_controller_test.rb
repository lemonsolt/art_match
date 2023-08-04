require "test_helper"

class Artist::EventBookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_event_bookmarks_show_url
    assert_response :success
  end
end
