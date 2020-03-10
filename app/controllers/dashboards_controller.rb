class DashboardsController < ApplicationController
  def user_dashboard
    @user = current_user
    @next_pickup = @user.pickups.where('date >= ? AND status= ?', Date.today, 'pending').first
    @previous_pickups = @user.pickups.where('status= ?', 'complete').order(date: :desc).limit(10)
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
