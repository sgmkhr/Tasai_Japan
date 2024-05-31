Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    root to: 'homes#menu'
  end
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions:      'public/sessions'
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'about', to: 'homes#about'
    get 'menu',  to: 'homes#menu'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
