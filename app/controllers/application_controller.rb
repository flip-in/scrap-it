class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: [:devise_controller?, :drivers_controller?]
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  before_action :redirect_if_no_onboarding, unless: [:devise_controller?]

  #  Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def standard_nav
    @nav_bar_partial = "path/to/standard/nav/partial"
  end
  
  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  def after_sign_in_path_for(resource)
    if current_driver
      '/driver/dashboard'
    else
      if resource.user_rewards.empty?
        '/onboarding'
      else
        '/dashboard'
      end
    end
  end

  def redirect_if_no_onboarding
    if current_user && current_user.first_name.nil?
      redirect_to edit_registration_path(current_user) unless controller_name == 'users'
    elsif current_user && current_user.user_categories.empty?
      redirect_to onboarding_path unless action_name == 'onboarding' || controller_name == 'user_categories'
    elsif current_user && current_user.user_rewards.empty?
      redirect_to new_user_reward_path unless controller_name == 'user_rewards'
    end
  end

  private

  def drivers_controller?
    params[:controller].match?(/drivers/)
  end

  def skip_pundit? #
    params[:controller] !~ /pickups/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :user_name])
  end
end
