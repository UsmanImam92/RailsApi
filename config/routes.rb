Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth' , skip: [:omniauth_callbacks]


  get 'user_posts' => 'posts#user_posts'

  resources :posts do
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
    resources :comments
  end

  resources :profile

end
