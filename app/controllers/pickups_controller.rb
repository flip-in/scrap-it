class PickupsController < ApplicationController
  after_action :authorize_pickups, except: [:index]
  before_action :set_pickup, only: [:edit, :review, :update, :destroy]

  def index
    #for the driver
    @pickups = policy_scope(Pickup).order(date: :desc)
  end

  def new
    #Scheduling page
    @pickup = Pickup.new
  end

  def create
    # POST action
    @pickup = Pickup.new(user_pickup_params)
    @pickup.user = current_user
    @pickup.save
    redirect_to user_dashboard_path
  end

  def edit
    # FOR USER TO CHANGE THE DATE
  end

  def review
    # FOR THE DRIVER TO REVIEW THE PICKUP
  end

  def update
    # Patch action
    # used on the review page and edit page
    if current_user.class == driver
      if @pickup.update(driver_pickup_params)
        redirect_to driver_dashboard_path
      else
        render 'review'
      end
    else
      if @pickup.update(user_pickup_params)
        redirecto_to user_dashboard_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    # Cancel a pickup
    @pickup.destroy
  end

  private

  def authorize_pickups
    authorize @pickup
  end

  def set_pickup
    @pickup = Pickup.find(params[:id])
  end

  def user_pickup_params
    params.require(:pickup).permit(:date, :time_of_day, :notes)
  end

  def driver_pickup_params
    params.require(:pickup).permit(:rating, :feedback)
  end

end
