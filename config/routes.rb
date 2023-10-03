Rails.application.routes.draw do

  # Deviseによる認証関連
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # ユーザー情報関連のルーティング
  resources :users do
    collection do
      get 'body_info'
      get 'gender_age'
      get 'height_weight_goal'
      get 'activity_level'
      get 'allergies'
      # マイページ関連
      get 'my_page', to: 'users#edit_profile'      # => /my_page
      patch 'my_page', to: 'users#update_profile'  # => /my_page
      # アカウント設定関連
      get 'account_settings', to: 'users#edit_account'      # => /account_settings
      patch 'account_settings', to: 'users#update_account'  # => /account_settings
    end
    # お気に入りレシピ
    resources :favorites, only: [:index]   # => /users/:user_id/favorites
  end

  # ダッシュボード
  get 'dashboard', to: 'dashboard#show'

  # レシピ関連
  resources :recipes, only: [:index, :show] do
    collection do
      get 'search'  # => /recipes/search
      get 'search_results'  # => /recipes/search_results
    end
  end
end
