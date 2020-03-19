class PickupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:update, :review, :approve, :disapprove, :feedback]
  before_action :set_pickup, only: [:edit, :review, :update, :destroy, :approve, :disapprove, :feedback]
  before_action :authorize_pickups, except: [:index, :new, :create, :approve, :disapprove, :feedback]

  def pundit_user
    if current_driver
      current_driver
    else
      current_user
    end
  end
  def index
    #for the driver
    @pickups = policy_scope(Pickup).order(date: :desc)
  end

  def new
    #Scheduling page
    if current_user.address.nil?
      redirect_to edit_user_path(current_user)
    end
    @pickup = Pickup.new
    authorize @pickup
  end

  def create
    # POST action
    @pickup = Pickup.new(user_pickup_params)
    @pickup.user = current_user
    authorize @pickup
    @pickup.save
    if current_user.pickups.length == 1
      current_user.points += 100
      current_user.lifetime_points += 100
      current_user.save
    end
    redirect_to user_dashboard_path
  end

  def edit
    # FOR USER TO CHANGE THE DATE
  end

  def review
    # FOR THE DRIVER TO REVIEW THE PICKUP
  end

  def approve
    authorize @pickup
    @pickup.user.lifetime_points += 25
    @pickup.user.points += 25
    @pickup.rating = true
    @pickup.status = 'complete'
    @pickup.user.save
    @pickup.save
    Badge.where('points <= ?', current_user.lifetime_points).each do |badge|
      unless current_user.badges.include?(badge)
      UserBadge.create!(user: current_user, badge: badge)
      end
    end
    respond_to do |format|
        format.html { redirect_to driver_dashboard_path }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
  end

  def disapprove
    authorize @pickup
    @pickup.rating = false
    @pickup.save
    respond_to do |format|
      format.html { redirect_to driver_dashboard_path }
      format.js
    end
  end

  def feedback
    @pickup.feedback = params[:pickup][:feedback].join("/")
    # "Feedback 2/Feedback 3" -- split in the view
    @pickup.status = params[:pickup][:status]

    authorize @pickup
    @pickup.save
    redirect_to driver_dashboard_path
  end


  def update
    # Patch action
    # used on the driver dashboard page and edit page
    if current_driver
      if @pickup.update(driver_pickup_params)
        redirect_to driver_dashboard_path
      else
        render 'review'
      end
    else
      if @pickup.update(user_pickup_params)
        redirect_to user_dashboard_path
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
    params.require(:pickup).permit(:rating, :feedback, :status)
  end

end
