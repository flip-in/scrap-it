class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to user_dashboard_path if current_user
    # redirect_to driver_dashboard_path if current_driver
    # landing page
  end

  def map
    # map for driver
  end

  def onboarding
    # TODO: write pseudo code for this
  end
end
