BikeCommuteChallenge::Application.routes.draw do
  devise_for :users

  get "/secret" => "home#secret", as: "secret"

  root to: "home#index"
end
