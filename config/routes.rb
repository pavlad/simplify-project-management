Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :tasks do
      member do
        put :mark_done
      end
    end
    resources :issues
    resources :assignments
  end
  resources :users do
    get 'projects', on: :member
    get 'tasks', on: :member
  end
  resources :clients

  namespace :user do
    resources :tasks
  end

  scope "settings" do
    root :to => "user_management#index"
  end
end
