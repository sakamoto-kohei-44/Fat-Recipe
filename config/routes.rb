Rails.application.routes.draw do
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'pages#home'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get '/home', to: 'pages#dashboard', as: 'dashboard_home'
  get 'recipe_suggestions/index', as: 'recipe_suggestions'
  get 'recipes/search'
  get 'recipes/search_results'
  patch 'users/update_profile', to: 'users#update_profile'
  patch 'users/update_account', to: 'users#update_account'

  # 利用規約とプライバシーポリシー
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'
  # ユーザー情報関連のルーティング
  resources :users do
    collection do
      get 'body_info'
      get 'gender_age', as: 'gender_age'
      get 'height_weight_target_weight'
      get 'activity_level'
      get 'allergies'
      post 'save_goal', to: 'users#save_goal', as: 'save_goal' #ユーザーが目標（標準体型または細マッチョ）を選択したときに、その情報を保存するためのアクションを実行するためのもの
      post 'save_gender_age', to: 'users#save_gender_age', as: 'save_gender_age' #ユーザーの年齢、性別
      post 'save_height_weight_target_weight', to: 'users#save_height_weight_target_weight', as: 'save_height_weight_target_weight'
      post 'save_activity_level', to: 'users#save_activity_level', as: 'save_activity_level'
      post 'save_allergies', to: 'users#save_allergies', as: 'save_allergies'
      # アカウント設定関連
      get 'account_settings', to: 'users#edit_account', as: 'edit_account'
    end
    # お気に入りレシピ
    resources :favorites, only: [:index]   # => /users/:user_id/favorites
  end

  # プロフィール
  resource :profile, only: %i[show edit update]

  # ダッシュボード
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # レシピ関連
  resources :recipes, only: [:index, :show] do
    collection do
      get 'search'  # => /recipes/search
      get 'search_results'  # => /recipes/search_results
    end
  end
end
