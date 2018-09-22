Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :employees do
        get :all, on: :collection
      end
      resources :currencies do
        get :all, on: :collection
      end
      resources :movements, only: [:index] do
        post :spending, on: :collection
        post :sale, on: :collection
        get :spending_codes, on: :collection
      end
    end
  end
end
