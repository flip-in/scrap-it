class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:driver_dashboard]
  before_action :authenticate_driver!, unless: :devise_controller?, only: [:driver_dashboard]

  def user_dashboard
    #SCHEDULE
    @user = current_user
    @next_pickup = @user.pickups.where('date >= ? AND (status = ? OR status = ?)', Date.today, 'pending', 'confirmed').order(date: :asc).first
    @previous_pickups = @user.pickups.where('status= ?', 'complete').order(date: :desc).limit(10)
    @random_rewards = current_user.rewards.where('point_cost > ?', current_user.points)
    @random_reward = @random_rewards.sample
    #REWARDS
    @all_rewards = Reward.all
    @user_rewards = current_user.rewards.order(point_cost: :asc)
    @rewards = Reward.where(category_id: current_user.user_categories.pluck(:category_id)).order(point_cost: :desc)
    @rewards = @rewards.reject { |i| @user_rewards.include? i }
    # end
    @completed_pickups_number = current_user.pickups.where(status: "complete").count
    if @completed_pickups_number > 0
      @pickuped_up_kgs = @completed_pickups_number * 2 + 3
    else 
      @pickuped_up_kgs = 0
    end
    @completed_pickups_total = Pickup.where(status: "complete").count
    @diverted_total = @completed_pickups_total * 2
  end

  def driver_dashboard
    @driver = current_driver
    @pickups = @driver.pickups.where("status != 'complete' AND date = ?", Date.today)
    @past_pickups = @driver.pickups.where("status = 'complete'").order(date: :desc)
    # map
    # scan
    # review
  end
end
