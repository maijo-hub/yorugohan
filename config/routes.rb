Rails.application.routes.draw do

  # 管理者
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  # 一般ユーザー
  scope module: :public do
    devise_for :users
    root to: 'dinners#top'

    resources :recipes, only: [:index, :show, :create, :edit, :update, :destroy]

    # 投稿関連
    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    # 夜ごはん
    resources :dinners, only: [:index, :show, :new, :create, :edit, :update, :destroy]

    # 検索
    get 'search', to: 'searches#search', as: 'public_search'

    # ユーザー関連
    get '/mypage', to: 'users#mypage', as: 'mypage'
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'confirm_withdrawal'
        patch 'withdraw'
      end
    end
  end

  # 管理者用
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

end
