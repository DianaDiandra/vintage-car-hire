require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bookings_index_url
    assert_response :success
  end

  test "should get create" do
    get bookings_create_url
    assert_response :success
  end

  test "should get update" do
    get bookings_update_url
    assert_response :success
  end
end
