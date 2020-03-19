class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to onboarding_path
    else
      render 'edit'
    end
  end



  def user_params
  params.require(:user).permit(:address, :first_name, :last_name, :phone_number)
  end
end
