Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'pages#home'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get '/home', to: 'pages#dashboard', as: 'dashboard_home'
  get 'recipe_suggestions/index', as: 'recipe_suggestions'
  patch 'users/update_profile', to: 'users#update_profile'
  patch 'users/update_account', to: 'users#update_account'

  # 利用規約とプライバシーポリシー
  get 'terms', to: 'pages#terms', as: 'pages_terms'
  get 'privacy', to: 'pages#privacy', as: 'pages_privacy'
  # ユーザー情報関連のルーティング
  resources :users do
    collection do
      get 'goal'
      get 'gender_age', as: 'gender_age'
      get 'height_weight_target_weight'
      get 'activity_level'
      get 'allergies'
      get 'confirmation', to: 'users#confirmation'
      post 'save_goal', to: 'users#save_goal'
      post 'save_gender_age', to: 'users#save_gender_age', as: 'save_gender_age' #ユーザーの年齢、性別
      post 'save_height_weight_target_weight', to: 'users#save_height_weight_target_weight'
      post 'save_activity_level', to: 'users#save_activity_level'
      post 'save_allergies', to: 'users#save_allergies'
      # アカウント設定関連
      get 'account_settings', to: 'users#edit_account', as: 'edit_account'
    end
    member do
      delete :destroy
    end
  end

  # プロフィール
  resource :profile, only: %i[show edit update]

  # ダッシュボード
  resources :dashboard, only: [:index]

  # レシピ関連
  resources :recipes, only: [:index, :show] do
    collection do
      get 'search'  # => /recipes/search
      get 'search_results'  # => /recipes/search_results
      get 'recipes/:id', to: 'recipes#show', as: :recipe
    end
  end
end
