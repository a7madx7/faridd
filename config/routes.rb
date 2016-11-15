Rails.application.routes.draw do
  get '/trade_center', to: 'offers#index', as: :trade_center
  resources :offers
  resources :formulations
  get 'search/search'

  get 'articles/recent', to: 'articles#recent', as: :recent_articles
  get 'articles/trending', to: 'articles#trending', as: :trending_articles

  resources :articles

  get 'rxes/dispense', to: 'rxes#new'

  resources :rxes
  resources :patients
  resources :answers

  resources :questions do
    resources :answers
  end
  resources :comments
  resources :companies
  resources :categories
  get 'drugs/pricey', to: 'drugs#pricey', as: :pricey_drugs
  get 'drugs/cheap', to: 'drugs#cheap', as: :cheap_drugs
  get 'drugs/recent', to: 'drugs#recent', as: :recent_drugs
  get 'drugs/trending', to: 'drugs#trending', as: :trending_drugs

  resources :generics

  resources :drugs do
    resources :generics
  end
  resources :countries
  devise_for :users, controllers: { registrations: 'user/registrations' }

  get 'welcome/home', as: :home
  get 'welcome/about', as: :about
  get 'trade_names', to: 'drugs#index', as: :trade_names
  get 'search', to: 'search#search', as: :search

  get 'identical_drugs/:id', to: 'drugs#identical_drugs', as: :identical_drugs

  resources :users do
    resources :questions
    resources :answers
    resources :drugs
    resources :generics
    resources :articles
    resources :comments
  end
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
