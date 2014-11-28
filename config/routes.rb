Rails.application.routes.draw do
  root 'welcome#index'
  get 'examples(/:action)', controller: 'examples', as: :examples
end
