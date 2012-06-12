BikeChallenge::Application.routes.draw do

  resources :teams do
    member do
      get :join, :leave
    end 
  end

  resources :competitions do
    #resources :business_sizes
    resources :competitions_teams do
      get :delete, :on => :collection
      post :remove, :on => :collection
    end
  end

  root :to => "competitions#index"

  devise_for :users

  resources :users, :only => [:show, :index]
end
