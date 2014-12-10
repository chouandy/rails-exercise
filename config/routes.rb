Rails.application.routes.draw do
  ## Post
  resources :posts

  ## Devise & User
  devise_for :user, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get ':id' => 'users#show', as: :user_profile
  get ':id/setting' => 'users#edit', as: :user_setting
  match ':id/setting' => 'users#update', via: [:put, :patch]
  get ':id/change_password' => 'users#edit_password', as: :user_change_password
  match ':id/change_password' => 'users#update_password', via: [:put, :patch]

  ## Common
  get 'examples(/:action)', controller: 'examples', as: :examples
  root 'welcome#index'
end
