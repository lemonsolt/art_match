require "test_helper"

class Artist::AtogFollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_atog_follows_show_url
    assert_response :success
  end
end
