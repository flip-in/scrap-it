class DashboardsController < ApplicationController
  def user_dashboard
    @user = current_user
    @next_pickup = @user.pickups.where('date >= ? AND status = ? OR status = ?', Date.today, 'pending', 'confirmed').order(date: :asc).first
    @previous_pickups = @user.pickups.where('status= ?', 'complete').order(date: :desc).limit(10)
    @user_rewards = current_user.rewards.order(point_cost: :asc)
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id)).order(point_cost: :asc)
    @rewards = @rewards.reject { |i| @user_rewards.include? i }
    # Scheduling
    # Rewards
    # Impact
  end

  def driver_dashboard
    # map
    # scan
    # review
  end
end
