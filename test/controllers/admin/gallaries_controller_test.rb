require "test_helper"

class Admin::GallariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_gallaries_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_gallaries_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_gallaries_edit_url
    assert_response :success
  end
end
