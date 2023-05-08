Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index, :show, :create, :update, :destroy]
      end
      resources :posts, only: [:index, :show]
    end
  end
end
