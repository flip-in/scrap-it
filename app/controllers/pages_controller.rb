class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :map, :qr]
  before_action :authenticate_driver!, unless: :devise_controller?, only: [:map]

  def home
    redirect_to user_dashboard_path if current_user
    redirect_to driver_dashboard_path if current_driver
    # landing page
  end

  def map
    @driver = current_driver
    @pickups = @driver.pickups.where("status != 'complete' AND date = ?", Date.today)
    @markers = @pickups.map do |pickup|
      {
        lat: pickup.user.latitude,
        lng: pickup.user.longitude
      }
      # raise
    end
    # map for driver
  end

  def onboarding
    # TODO: write pseudo code for this
  end

  def about
  end

  def profile
  end

  def qr
    @user = User.find(params[:user_id])
    @current_pickup = @user.pickups.where('date = ?', Date.today)[0]
    if current_driver
      redirect_to review_pickup_path(@current_pickup)
    elsif !current_user && !current_driver
      redirect_to new_driver_session_path
    end
  end
end
