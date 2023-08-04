require "test_helper"

class Artist::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get artist_homes_top_url
    assert_response :success
  end
end
