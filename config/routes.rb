Rails.application.routes.draw do
  get 'items/new'
  get 'items/show'

  resources :items
  
end
