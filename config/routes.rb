Rails.application.routes.draw do
  resources :employees
  resources :currencies
  resources :movements, only: [:index] do
    post :spending, on: :collection
    post :sale, on: :collection
  end
end
