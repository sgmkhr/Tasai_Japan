require "test_helper"

class Public::CounselingRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_counseling_rooms_index_url
    assert_response :success
  end

  test "should get new" do
    get public_counseling_rooms_new_url
    assert_response :success
  end

  test "should get show" do
    get public_counseling_rooms_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_counseling_rooms_edit_url
    assert_response :success
  end
end
