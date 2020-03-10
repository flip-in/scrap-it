require 'test_helper'

class UserRewardsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_rewards_create_url
    assert_response :success
  end

end
