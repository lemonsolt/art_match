require "test_helper"

class Artist::GtoaFollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_gtoa_follows_show_url
    assert_response :success
  end
end
