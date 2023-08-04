require "test_helper"

class Gallary::GtoaFollowControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gallary_gtoa_follow_show_url
    assert_response :success
  end
end
