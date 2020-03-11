class UserRewardsController < ApplicationController

  def new
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id))
  end


  def create
    current_user.user_rewards.destroy_all
    @rewards_array = params[:rewards_ids]
    @rewards_array.each do |id|
      UserReward.create(
        reward_id: id,
        user: current_user
      )
    end
    # WHEN a user redeems a reward, this a user_reward is created
    redirect_to user_dashboard_path
  end
end
