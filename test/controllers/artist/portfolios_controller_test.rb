require "test_helper"

class Artist::PortfoliosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_portfolios_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_portfolios_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_portfolios_edit_url
    assert_response :success
  end
end
