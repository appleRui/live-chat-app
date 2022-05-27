Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  # https://railsguides.jp/routing.html#%E3%83%A1%E3%83%B3%E3%83%90%E3%83%BC%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B
  resources :messages, only: ['index'] do
    member do
      resources :likes, only: ['create'], id: '/^[a-z]+$/'
    end
  end

  resources :rooms, only: ['index'],id: '/^[a-z]+$/'

  resources :likes, only: ['destroy']
#   mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
