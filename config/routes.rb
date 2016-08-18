Rails.application.routes.draw do
  resources :companies
  resources :categories
  resources :drugs
  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :generics

  get 'welcome/home', as: :home_path
  get 'welcome/about', as: :about_path
  # get 'user/:id', to: 'users#show', as: :user
  # get 'users', to: 'users#index', as: :users_path
  # get ''
  resources :users
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
