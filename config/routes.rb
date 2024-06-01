Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#menu'
    resources :users, only: [:show, :index, :destroy], param: :canonical_name
    patch 'users/:canonical_name/cancel', to: 'users#cancel', as: 'cancel'
    patch 'users/:canonical_name/withdraw', to: 'users#withdraw', as: 'withdraw'
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions:      'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about', to: 'homes#about'
    get 'menu',  to: 'homes#menu'
    resources :users, only: [:show, :index, :edit, :update], param: :canonical_name
    patch 'users/withdraw', to: 'users#withdraw', as: 'withdraw'
    get 'users/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
