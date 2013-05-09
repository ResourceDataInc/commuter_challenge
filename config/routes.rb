BikeCommuteChallenge::Application.routes.draw do
  devise_for :users

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

  root to: "home#index"
end
