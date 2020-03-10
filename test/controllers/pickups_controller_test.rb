require 'test_helper'

class PickupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pickups_index_url
    assert_response :success
  end

  test "should get new" do
    get pickups_new_url
    assert_response :success
  end

  test "should get edit" do
    get pickups_edit_url
    assert_response :success
  end

  test "should get review" do
    get pickups_review_url
    assert_response :success
  end

  test "should get destroy" do
    get pickups_destroy_url
    assert_response :success
  end

  test "should get create" do
    get pickups_create_url
    assert_response :success
  end

  test "should get update" do
    get pickups_update_url
    assert_response :success
  end

end
