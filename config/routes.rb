Rails.application.routes.draw do
  devise_for :users
  root "posts#feed"
  get "feels_unsigned", to: "home#index", as: "home_index"
  get "feed/posts", to: "posts#feed", as: "feed"
  get "result", to: "users#search", as: "search_users"
  get "followers/:id", to: "users#show_followers", as: "followers"
  get "following/:id", to: "users#show_following", as: "following"
  post "like/post", to: "posts#like", as: "like_post"
  post "unlike/post", to: "posts#unlike", as: "unlike_post"
  post "follow/user", to: "users#follow", as: "follow_user"
  post "unfollow/user", to: "users#unfollow", as: "unfollow_user"
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
    resources :comments
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
