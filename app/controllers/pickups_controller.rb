class PickupsController < ApplicationController
  after_action: :authorize_pickups, except: [:index]
  before_action: :set_pickup, only: [:edit, :review, :update, :destroy]
  
  def index
    #for the driver
    @pickups = policy_scope(Pickup).order(date: :desc)
  end

  def new
    #Scheduling page

  end

  def edit
    # FOR USER TO CHANGE THE DATE
  end

  def review
    # FOR THE DRIVER TO REVIEW THE PICKUP
  end

  def destroy
    # Cancel a pickup
  end

  def create
    # POST action
  end

  def update
    # Patch action
    # used on the review page and edit page
  end

  private 
  
  def authorize_pickups
    authorize @pickup
  end

  def set_pickup
    @pickup = Pickup.find(params[:id])
  end


end
