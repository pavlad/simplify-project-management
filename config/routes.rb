Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users, controllers: { registrations: "registrations", invitations: "users/invitations" }
  root :to => 'passthrough#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :deliverables, only: :destroy
    resources :project_files, only: :destroy
    resources :timelines do
      post 'invite_client', on: :collection
    end
    resources :tasks do
      member do
        put :mark_done
      end
    end
    resources :issues do
      member do
        put :mark_as_resolved
      end
    end
    resources :assignments
  end
  resources :users do
    get 'projects', on: :member
    get 'tasks', on: :member
    get 'show_consultant', on: :member
  end
  resources :clients

  namespace :user do
    resources :tasks do
      put 'mark_done'
    end
  end
  namespace "settings" do
    root to: "user_management#index", as: "user_management"
  end

  resources :dashboard, only: [:index] do
    collection do
      get 'overview'
      get 'delete'
    end
  end

  namespace :client do
    resources :dashboard, only: [:index]
  end

end
