class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :authenticate
  skip_before_action :authenticate_user!

    def facebook
    # skip_authorization
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in(@user)
        if @user.categories.empty?        
          redirect_to onboarding_path #this will throw if @user is not activated
          set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        else
          redirect_to user_dashboard_path
        end
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  
    def failure
      redirect_to root_path
    end
  end