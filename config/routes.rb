Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'b2b', to: 'visitors#b2b'
  get 'b2bform', to: 'visitors#b2bform'

  resources :visitors do
  	collection { get :sendinvoice }
  end
end
