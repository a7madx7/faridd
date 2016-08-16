Rails.application.routes.draw do
  resources :companies
  resources :categories
  resources :drugs
  devise_for :users, controllers: {registrations: 'user/registrations'}

  resources :generics

  get 'welcome/home', as: :home_path
  get 'welcome/about', as: :about_path
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
