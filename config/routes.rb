# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  get '/' => redirect('/magazines')

  resources :magazines, only: %i(create show), constraints: { id: /\d+/ }
  namespace :magazines do
    resources :dashboard, only: %i(index destroy)
    resources :import, only: %i(create update)
  end

  scope :api do
    scope :web do
      resources :magazines, only: %i(index)
      resources :episodes, only: %i(show), constraints: { id: /\d+/ }
      namespace :episodes do
        resources :author, only: %i(index)
        resources :magazine, only: %i(show)
      end
    end
  end

  resources :pages, only: %i(show)

  %w(/magazines /magazines/new /episodes/magazine/:id /episodes/:id).each do |path|
    get path => 'react#mount_page'
  end

  mount Sidekiq::Web => '/sidekiq'
end
