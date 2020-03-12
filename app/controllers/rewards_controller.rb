class RewardsController < ApplicationController
  def index
    # View rewards
    # Filter Rewards
  end

  def redeem
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id))

    # Arrive here when you click on "redeem reward"
  end
end
