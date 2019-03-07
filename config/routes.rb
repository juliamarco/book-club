Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/books', to: 'books#index'
  get '/books/new', to: 'books#new', as: :new_book
  post '/books', to: 'books#create'
  get '/books/:id', to: 'books#show', as: :book
  get '/books/:id/edit', to: 'books#edit'
  put '/books/:id', to: 'books#update'
  delete '/books/:id', to: 'books#destroy'

  get '/books/:book_id/reviews', to: 'reviews#index'
  get '/books/:book_id/reviews/new', to: 'reviews#new', as: :new_book_review
  post '/books/:book_id/reviews/', to: 'reviews#create', as: :book_reviews
  get '/reviews/:id', to: 'reviews#show', as: :review
  delete '/reviews/:id', to: 'reviews#destroy'

  get '/users/:id', to: 'users#show', as: :user

  get '/authors/:id', to: 'authors#show', as: :author
  delete '/authors/:id', to: 'authors#destroy'

  # resources :books do
  #   resources :reviews, shallow: true
  # end
  #
  # resources :authors
  # resources :welcome, only: [:index]
  #
  # resources :users, only: [:show]
end
