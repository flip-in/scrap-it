require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get onboarding" do
    get pages_onboarding_url
    assert_response :success
  end

  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get map" do
    get pages_map_url
    assert_response :success
  end

end
