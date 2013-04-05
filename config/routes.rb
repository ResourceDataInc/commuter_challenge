BikeCommuteChallenge::Application.routes.draw do
  devise_for :users

  resources :competitions do
    get :delete, on: :member
  end

  get "/secret" => "home#secret", as: "secret"

  root to: "home#index"
end
