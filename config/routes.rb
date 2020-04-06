Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show] do
    resources :friendships, only: %i[index create destroy update]
    get 'friendships/received', to: 'friendships#received', as: 'friendships_received'
    get 'friendships/sent', to: 'friendships#sent', as: 'friendships_sent'
    post 'friendships/accept', to: 'friendships#accept', as: 'friendships_accept'
    post 'friendships/reject', to: 'friendships#reject', as: 'friendships_reject'
    post 'friendships/cancel', to: 'friendships#cancel', as: 'friendships_cancel'
  end
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
