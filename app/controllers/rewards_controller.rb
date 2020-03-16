class RewardsController < ApplicationController
  def index
    # View rewards
    # Filter Rewards
  end

  def show
    @reward = Reward.find(params[:id])
    respond_to do |format|
      format.html { redirect_to user_dashboard_path }
      format.js
    end
  end

  def filter
    filter_rewards = Reward.joins(:category).where("categories.name = ?", params[:reward_query])
    @rewards = Reward.where(category_id: filter_rewards.pluck(:category_id)).order(point_cost: :asc)
    respond_to do |format|
      format.html { redirect_to user_dashboard_path }
      format.js
    end
  end

  def reset
    @all_rewards = Reward.all.order(point_cost: :desc)
    respond_to do |format|
      format.html { redirect_to user_dashboard_path }
      format.js
    end
  end

  def redeem
    raise
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id))

    # Arrive here when you click on "redeem reward"
  end
end
