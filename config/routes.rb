BikeChallenge::Application.routes.draw do

  resources :competitions do
    resources :business_sizes
  end

  root :to => "competitions#index"

  devise_for :users

  resources :users, :only => [:show, :index]
end
