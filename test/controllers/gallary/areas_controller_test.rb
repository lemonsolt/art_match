require "test_helper"

class Gallary::AreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gallary_areas_index_url
    assert_response :success
  end

  test "should get show" do
    get gallary_areas_show_url
    assert_response :success
  end
end
