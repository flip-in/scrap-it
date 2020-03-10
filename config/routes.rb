Rails.application.routes.draw do
  devise_for :drivers
  devise_for :users
  root to: 'pages#home'
  
  resources :pickups, except: [:show]
  resources :rewards, only: [:index]

  get '/onboarding', to: 'pages#onboarding', as: :onboarding
  # ROUTES FOR 2 DASHBOARDS
  get '/dashboard', to: 'dashboards_controller#user_dashboard', as: :user_dashboard
  get '/driver/dashboard', to: 'dashboards_controller#driver_dashboard', as: :driver_dashboard
  # MAP FOR DRIVER TO SEE ALL PICKUPS
  get '/driver/map', to: 'pages#map', as: :map
  # ROUTES FOR MANAGING USER REWARD PREFERENCE CATEGORIES
  get '/preferences/manage', to: 'user_categories#new', as: :manage_preferences
  post '/preferences', to: 'user_categories#create'
  # REDEEM CODE (pseudo 'new' action) -> CREATE USER_REWARD
  get '/rewards/:id/redeem', to: 'rewards#redeem', as: :redeem_reward
  post '/rewards/:id', to: 'user_rewards#create'
  # FOR DRIVER TO REVIEW A PICKUP
  # TODO: Trigger callback function on USER Model
  get '/pickups/:id/review', to: 'pickups#review', as: :review_pickup

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
