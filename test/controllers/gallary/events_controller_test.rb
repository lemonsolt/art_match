require "test_helper"

class Gallary::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gallary_events_index_url
    assert_response :success
  end

  test "should get show" do
    get gallary_events_show_url
    assert_response :success
  end

  test "should get edit" do
    get gallary_events_edit_url
    assert_response :success
  end

  test "should get before_index" do
    get gallary_events_before_index_url
    assert_response :success
  end

  test "should get now_index" do
    get gallary_events_now_index_url
    assert_response :success
  end

  test "should get after_index" do
    get gallary_events_after_index_url
    assert_response :success
  end
end
