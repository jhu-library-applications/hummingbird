# frozen_string_literal: true

Rails.application.routes.draw do
  resources :database_headings
  resources :headings
  resources :subcategories
  resources :categories
  resources :databases
  resources :vendors
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
end
