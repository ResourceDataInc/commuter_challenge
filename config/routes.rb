BikeCommuteChallenge::Application.routes.draw do
  get "dashboard" => "dashboard#index"
  get "help" => "home#index"
  devise_for :users, controllers: { registrations: :registrations }

  resources :competitions do
    get :delete, on: :member
    resources :brackets
    resources :competitors do
      get :delete, on: :member
    end

  end

  resources :teams do
    get :delete, on: :member
    resources :memberships do
      get :delete, on: :member
    end
  end

  resources :rides do
    get :delete, on: :member
  end

  resources :users, only: %i{show}

  root to: "home#index"
end
