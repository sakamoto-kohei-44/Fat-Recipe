Rails.application.routes.draw do
  root 'home#index'
  resources :pages

  # Deviseによる認証関連
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
end
