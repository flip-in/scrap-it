Rails.application.routes.draw do
  get 'users/edit'
  get 'users/update'
  devise_for :drivers
  devise_for :users, controllers: { registrations: "registrations",
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

#   constraints lambda { |req| !req.session[:user_id].blank? } do
#     root to: "dashboard#user_dashboard"
# end
  root to: 'pages#home'
  resources :users, only: [:edit, :update]
  resources :pickups, excepraiset: [:show]
  resources :rewards, only: [:index]
  resources :user_rewards, only: [:new]
  get '/onboarding', to: 'pages#onboarding', as: :onboarding
  # ROUTES FOR 2 DASHBOARDS
  get '/dashboard', to: 'dashboards#user_dashboard', as: :user_dashboard
  get '/driver/dashboard', to: 'dashboards#driver_dashboard', as: :driver_dashboard
  # MAP FOR DRIVER TO SEE ALL PICKUPS
  get '/driver/map', to: 'pages#map', as: :map
  # ROUTES FOR MANAGING USER REWARD PREFERENCE CATEGORIES
  get '/preferences/manage', to: 'user_categories#new', as: :manage_preferences
  post '/user_categories', to: 'user_categories#create'
  # REDEEM CODE (pseudo 'new' action) -> CREATE USER_REWARD
  get '/rewards/:id/redeem', to: 'rewards#redeem', as: :redeem_reward
  post '/rewards/:id', to: 'user_rewards#create'
  post '/filter_rewards', to: 'rewards#filter', as: :filter_rewards
  post '/reset_rewards', to: 'rewards#reset', as: :reset_rewards
  post '/rewards', to: 'user_rewards#create', as: :user_rewards
  post '/add_user_rewards', to: 'user_rewards#add', as: :add_user_rewards





  # FOR DRIVER TO REVIEW A PICKUP
  # TODO: Trigger callback function on USER Model for checking eligibility of badges
  get '/pickups/:id/review', to: 'pickups#review', as: :review_pickup

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
