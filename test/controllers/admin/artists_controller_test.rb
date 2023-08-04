require "test_helper"

class Admin::ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_artists_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_artists_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_artists_edit_url
    assert_response :success
  end
end
