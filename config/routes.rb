Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'examples(/:action)', controller: 'examples', as: :examples
  root 'welcome#index'
end
