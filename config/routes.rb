Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/update'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :wish_lists do
    resources :items
  end
  resources :bookings, only: [:create, :index, :destroy]
end
