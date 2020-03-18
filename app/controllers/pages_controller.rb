class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :map, :qr]
  before_action :authenticate_driver!, unless: :devise_controller?, only: [:map, :qr]

  def home
    redirect_to user_dashboard_path if current_user
    redirect_to driver_dashboard_path if current_driver
    # landing page
  end

  def map
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
    @driver = current_driver
    @pickups = @driver.pickups.where("status != 'complete' AND date = ?", Date.today)
  end
end
