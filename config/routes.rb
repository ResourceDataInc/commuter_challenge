BikeChallenge::Application.routes.draw do
  resources :business_sizes

  resources :competitions

  root :to => "competitions#index"

  devise_for :users

  resources :users, :only => [:show, :index]
end
