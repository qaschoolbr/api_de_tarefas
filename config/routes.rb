require 'api_version_contraint'
Rails.application.routes.draw do
  #quero usa o recurso devise_for apenas para sessoes e o controle e o sessions
  devise_for :users, only: [:sessions], controller: { sessions: 'api/v1/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, constraints: {subdomain: 'api'}, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
    end
  end
end