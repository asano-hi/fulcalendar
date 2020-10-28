Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'hello#index'
  get 'hello/link' => 'hello#link'
  get '/schedules' => 'schedules#index'

    namespace :api, {format: 'json'} do
      namespace :v1 do
        resources :events
      end
    end

end
