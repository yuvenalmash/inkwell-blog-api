Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Devise routes
      devise_for :users,
                 path: 'users',
                 path_names: {
                   sign_in: 'sign_in',
                   sign_out: 'sign_out',
                   registration: 'sign_up'
                 },
                 controllers: {
                   sessions: 'api/v1/users/sessions',
                   registrations: 'api/v1/users/registrations'
                 }

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
