class RegistrationsController < Devise::RegistrationsController
    protected
  
    def after_sign_up_path_for(resource)
        @user = current_user
        edit_user_path(@user) # Or :prefix_to_your_route
    end
  end