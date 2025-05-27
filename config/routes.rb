Rails.application.routes.draw do
  get 'mypage/index'
  devise_for :users
  get 'home/index'
  get '/mypage', to: 'mypage#index'
  root 'articles#index'
  resources :articles

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
