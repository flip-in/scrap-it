class UserRewardsController < ApplicationController

  def new
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id))
  end

  def add
    user_reward = UserReward.new(
      reward_id: params[:reward_id],
      user: current_user
    )
    if user_reward.save
      @user_rewards = current_user.rewards.order(point_cost: :asc)
      @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id)).order(point_cost: :desc)
      @rewards = @rewards.reject { |i| @user_rewards.include? i }
      respond_to do |format|
        format.html { redirect_to user_dashboard_path }
        format.js
      end
    else
      redirect_to user_dashboard_path
    end
  end

  def create
    current_user.user_rewards.destroy_all
    @rewards_array = params[:rewards_ids]
    # add the reward coming from the +add button here
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
