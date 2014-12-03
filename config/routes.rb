Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'users/omniauth' }

  get 'examples(/:action)', controller: 'examples', as: :examples
  root 'welcome#index'
end
