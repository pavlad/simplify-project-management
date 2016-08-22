Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :tasks do
      get 'mark_as_done', on: :member
      get 'unmark_as_done', on: :member
    end
    resources :issues
  end
  resources :users do
    get 'projects', on: :member
    get 'tasks', on: :member
  end
  resources :clients

end
