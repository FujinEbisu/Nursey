require "test_helper"

class SafePlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get safe_places_index_url
    assert_response :success
  end

  test "should get show" do
    get safe_places_show_url
    assert_response :success
  end

  test "should get new" do
    get safe_places_new_url
    assert_response :success
  end

  test "should get create" do
    get safe_places_create_url
    assert_response :success
  end
end
