Rails.application.routes.draw do
  devise_for :user

  get 'examples(/:action)', controller: 'examples', as: :examples
  root 'welcome#index'
end
