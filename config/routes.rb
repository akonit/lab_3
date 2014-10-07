Lab3::Application.routes.draw do

  root 'facultys#index'

  get "search/by_group"
  get "search/by_group_result"

  resources :groups

  resources :facultys

  resources :lessons
end
