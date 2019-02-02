Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books do
    resources :reviews, only: [:new, :create]
  end
  resources :authors
end
