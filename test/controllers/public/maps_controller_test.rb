require "test_helper"

class Public::MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_maps_show_url
    assert_response :success
  end

  test "should get index" do
    get public_maps_index_url
    assert_response :success
  end
end
