Rails.application.routes.draw do
  apipie
  devise_for :users, skip: [:sessions, :registrations], path_names: {sign_in: 'sessions'}
  as :user do
    post 'v1/sessions', to: 'v1/sessions#create'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
