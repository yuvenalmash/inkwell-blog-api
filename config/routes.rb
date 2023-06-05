Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users,
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        },
        controllers: {
          sessions: 'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations'
        }

      resources :users, only: [:index, :show, :update] do
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

  post '/api/v1/signup', to: 'api/v1/users/registrations#create'
  post '/api/v1/login', to: 'api/v1/users/sessions#create'
end
