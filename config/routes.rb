Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users, controllers: { registrations: "users/registrations", invitations: "users/invitations" }
  root to: 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :deliverables, only: :destroy
    resources :project_files, only: :destroy
    resources :timelines, except: :show
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
  end
  resources :clients

  resources :timelines, except: [:show]

  namespace :user do
    resources :tasks
  end
  namespace "settings" do
    root to: "user_management#index", as: "user_management"

  end
end
