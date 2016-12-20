Rails.application.routes.draw do
  get 'search/search'
  get '/trade_center', to: 'offers#index', as: :trade_center
  resources :offers
  resources :formulations

  get 'articles/recent', to: 'articles#recent', as: :recent_articles
  get 'articles/trending', to: 'articles#trending', as: :trending_articles
  get 'articles/popular', to: 'articles#popular', as: :popular_articles

  resources :articles

  get 'rxes/dispense', to: 'rxes#new'

  resources :rxes
  resources :patients
  resources :answers

  resources :questions do
    resources :answers
  end
  resources :comments

  get 'companies/popular', to: 'companies#popular', as: :popular_companies

  resources :companies

  get 'categories/popular', to: 'categories#popular', as: :popular_categories
  resources :categories

  get 'drugs/pricey', to: 'drugs#pricey', as: :pricey_drugs
  get 'drugs/cheap', to: 'drugs#cheap', as: :cheap_drugs
  get 'drugs/recent', to: 'drugs#recent', as: :recent_drugs
  get 'drugs/trending', to: 'drugs#trending', as: :trending_drugs
  get 'drugs/popular', to: 'drugs#popular', as: :popular_drugs

  get 'generics/recent', to: 'generics#recent', as: :recent_generics
  get 'generics/trending', to: 'generics#trending', as: :trending_generics
  get 'generics/popular', to: 'generics#popular', as: :popular_generics

  resources :generics

  resources :drugs do
    resources :generics
  end

  get 'countries/popular', to: 'countries#popular', as: :popular_countries

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
  resources :activities
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
