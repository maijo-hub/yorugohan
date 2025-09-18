Rails.application.routes.draw do
  # 管理者
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'top#index'   # /admin で管理者トップページへ

    resources :users, only: [:index, :show, :destroy] do
      member do
        patch :restore
      end
    end
    resources :comments, only: [:index, :destroy]   # コメント管理
    resources :reviews,  only: [:index, :destroy]   # レビュー管理
  end

  # 一般ユーザー
  scope module: :public do
    devise_for :users
    root to: 'dinners#top'

    # レシピ（new 以外すべて）
    resources :recipes, except: [:new]

    # 投稿画像（edit, update 以外すべて）
    resources :post_images, except: [:edit, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    # 夜ごはん（コメント付きで1回にまとめる）
    resources :dinners do
      resources :comments, only: [:create, :destroy]
    end

    # 検索
    get 'search', to: 'searches#search', as: 'public_search'
    get 'tag_search', to: 'dinners#tag_search', as: 'tag_search'
    
    # ユーザー関連
    get '/mypage', to: 'users#mypage', as: 'mypage'
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'confirm_withdrawal'
        patch 'withdraw'
      end
    end
  end
end
