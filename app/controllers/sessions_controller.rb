class SessionsController < ApplicationController

  protected

  def after_sign_up_path_for(resource)
      @user = current_user
      user_dashboard_path # Or :prefix_to_your_route
  end
end

