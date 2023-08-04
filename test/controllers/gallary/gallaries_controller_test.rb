require "test_helper"

class Gallary::GallariesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gallary_gallaries_show_url
    assert_response :success
  end

  test "should get edit" do
    get gallary_gallaries_edit_url
    assert_response :success
  end
end
