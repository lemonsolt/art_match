require "test_helper"

class Gallary::AtogFollowControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gallary_atog_follow_show_url
    assert_response :success
  end
end
