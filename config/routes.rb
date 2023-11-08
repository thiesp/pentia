Rails.application.routes.draw do
  apipie
  devise_for :users, skip: [:sessions, :registrations], path_names: {sign_in: 'sessions'}
  as :user do
    post 'v1/sessions', to: 'v1/sessions#create'
    post 'v1/registrations', to: 'v1/registrations#create'
  end

  namespace :v1 do
    resources :products, only: :index
    resource :basket, only: [:show, :destroy] do
      put :add_item
      put :remove_item
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
