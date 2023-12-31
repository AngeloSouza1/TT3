Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    get 'data', to: 'data#index'  # Alterado de 'data#show' para 'data#index'
  end
end