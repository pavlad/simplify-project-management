Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :deliverables, only: :destroy
    resources :project_files, only: :destroy
    resources :tasks do
      get 'mark_as_done', on: :member
      get 'unmark_as_done', on: :member
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
