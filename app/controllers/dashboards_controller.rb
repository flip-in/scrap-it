class DashboardsController < ApplicationController
  def user_dashboard
    @user = current_user
    @next_pickup = @user.pickups.where('date >= ? AND status = ? OR status = ?', Date.today, 'pending', 'confirmed').order(date: :asc).first
    @previous_pickups = @user.pickups.where('status= ?', 'complete').order(date: :desc).limit(10)
    @user_rewards = current_user.rewards.order(point_cost: :asc)
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id)).order(point_cost: :asc)
    @rewards = @rewards.reject { |i| @user_rewards.include? i }
    @completed_pickups_number = current_user.pickups.where(status: "complete").count
    @picked_up_kgs = @completed_pickups_number * 1.56
    @completed_pickups_total = Pickup.where(status: "complete").count
    @diverted_total = @completed_pickups_total * 1.56
    @user_badges = UserBadge.where(user: current_user)
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
