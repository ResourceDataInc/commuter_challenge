SummerBikeChallenge::Application.routes.draw do
  devise_for :cyclists

  resources :competitions
  
  root :to => 'competitions#index'

end
