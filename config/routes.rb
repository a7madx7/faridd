Rails.application.routes.draw do
  get 'search/search'

  resources :articles
  resources :rxes
  resources :patients
  resources :questions
  resources :comments
  resources :answers
  resources :companies
  resources :categories
  resources :drugs
  resources :countries
  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :generics

  get 'welcome/home', as: :home
  get 'welcome/about', as: :about
  get 'trade_names', to: 'drugs#index', as: :trade_names
  get 'search', to: 'search#search', as: :search
  get 'identical_drugs/:id', to: 'drugs#identical_drugs', as: :identical_drugs

  # get 'user/:id', to: 'users#show', as: :user
  # get 'users', to: 'users#index', as: :users_path
  # get ''
  resources :users
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
