Rails.application.routes.draw do
  
    devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  scope module: :public do
    devise_for :users
    root to: 'dinners#top'
    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    resources :dinners, only: [:index, :show, :new, :create, :edit, :update, :destroy]    

    resources :users, only: [:show, :edit, :update]
  end

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

end
