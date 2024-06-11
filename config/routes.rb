Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#menu'
    resources :users, only: [:show, :index, :destroy], param: :canonical_name do
      get 'followings' => 'relationships#followings', as: 'followings'
    	get 'followers'  => 'relationships#followers',  as: 'followers'
    end
    patch 'users/:canonical_name/cancel', to: 'users#cancel', as: 'cancel'
    patch 'users/:canonical_name/withdraw', to: 'users#withdraw', as: 'withdraw'
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :categories, only: [:index, :destroy] do
      resources :counseling_rooms, only: [:index, :show, :destroy] do
        resources :opinions, only: [:destroy]
      end
    end
    get 'categories/counseling_rooms/search', to: 'counseling_rooms#search', as: 'search_rooms'
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions:      'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about', to: 'homes#about'
    get 'menu',  to: 'homes#menu'
    resources :users, only: [:show, :index, :edit, :update], param: :canonical_name do
      resource :relationships, only: [:create, :destroy]
    	get 'followings', to: 'relationships#followings'
    	get 'followers',  to: 'relationships#followers'
    	get 'chat_rooms', to: 'chats#index'
    end
    patch 'users/:canonical_name/withdraw', to: 'users#withdraw', as: 'withdraw'
    get 'users/:canonical_name/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :post_favorites, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy] do
        resource :comment_favorites, only: [:create, :destroy]
      end
    end
    resources :categories, only: [:create, :index] do
      resources :counseling_rooms do
        resources :participations, only: [:create, :destroy, :update]
        resources :opinions, only: [:create, :destroy] do
          resource :opinion_favorites, only: [:create, :destroy]
        end
      end
    end
    get 'categories/counseling_rooms/search', to: 'counseling_rooms#search', as: 'search_rooms'
    resources :chats, only: [:show, :create, :destroy]
    resources :notifications, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
