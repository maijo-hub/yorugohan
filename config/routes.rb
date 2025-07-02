Rails.application.routes.draw do
  devise_for :users
  root to:"dinners#top"
  resources :dinners
end
