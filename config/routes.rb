Rails.application.routes.draw do
  resources :employees do
    get :all, on: :collection
  end
  resources :currencies do
    get :all, on: :collection
  end
  resources :movements, only: [:index] do
    post :spending, on: :collection
    post :sale, on: :collection
  end
end
