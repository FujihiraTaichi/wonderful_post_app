Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'articles#index'
  resources :articles
  resources :sample_articles

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
