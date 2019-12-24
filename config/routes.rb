Rails.application.routes.draw do
  resources :articles
  devise_for :users
  root to: 'articles#index'

  post 'like-article', to: 'articles#like_article'
  post 'bookmark-article', to: 'articles#bookmark_article'
  get 'bookmarks', to: 'articles#get_bookmarks'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
