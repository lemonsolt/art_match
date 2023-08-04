require "test_helper"

class Artist::DmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_dms_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_dms_show_url
    assert_response :success
  end
end
