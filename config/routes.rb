BikeChallenge::Application.routes.draw do

  resources :teams do
    get :join, :on => :member
    get :leave, :on => :member
  end

  resources :competitions do
    resources :business_sizes
  end

  root :to => "competitions#index"

  devise_for :users

  resources :users, :only => [:show, :index]
end
