Rails.application.routes.draw do
  get 'articles/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root 'welcome#index'
  
  resources :users do
    resources :groups
  end
  
  resources :businesses do
    resources :tags
    resources :groups
    resources :articles
    resources :contacts
  end
  
  resources :attachments, only: [:show, :new]
  
  resources :tags
  
end
