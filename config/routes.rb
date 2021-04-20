Rails.application.routes.draw do
  namespace :api do
     namespace :v1 do

       mount_devise_token_auth_for 'User', at: 'auth', controllers: {
           omniauth_callbacks: 'api/v1/auth/omniauth_callbacks',
           registrations: 'api/v1/auth/registrations',
       }

      resources :users
      resources :monitoring_settings do
        collection { post :import_csv }
      end
      resources :attempts, only: :create
      resources :user_and_monitoring_settings
      patch  '/manual_attempt_update', to: 'attempts#manual_attempt_update' #update attempt manualy
     end
  end
 end