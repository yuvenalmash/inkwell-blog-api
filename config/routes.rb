Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index, :show, :create, :update, :destroy] do
          resources :comments, only: [:index, :create, :update, :destroy] do
            resources :likes, only: [:index, :create, :destroy]
          end
          resources :likes, only: [:index, :create, :destroy]
        end
        resources :follows, only: [:index, :create, :destroy]
        resources :messages, only: [:index, :create, :update, :destroy]
      end

      resources :posts, only: [:index, :show]
    end
  end
end
