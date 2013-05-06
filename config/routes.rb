BikeCommuteChallenge::Application.routes.draw do
  devise_for :users

  resources :competitions do
    get :delete, on: :member
    resources :brackets
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

  get "/secret" => "home#secret", as: "secret"

  root to: "home#index"
end
