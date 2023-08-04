require "test_helper"

class Artist::ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_artists_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_artists_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_artists_edit_url
    assert_response :success
  end
end
