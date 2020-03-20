class UserCategoriesController < ApplicationController
  def new
    #/preferences/manage
    # for managing preferences (check boxes)
  end

  def create
    current_user.user_categories.destroy_all
    
    @categories_array = params[:categories_ids]
    if @categories_array.nil?
      render 'pages/onboarding'
    else
      @categories_array.each do |id|
        UserCategory.create(
          category_id: id,
          user: current_user
        )
    end

    redirect_to new_user_reward_path
  end

    # Destroy all previous preferences
    # Create new preferences with the selected categories
  end
end
