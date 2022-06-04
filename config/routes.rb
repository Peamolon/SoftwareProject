Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  root 'home#index'
  resources :teams, only: [:index, :show, :new, :create] do
    collection do
      put :remove_member
    end
  end
  resources :team_invitations, only: [:new, :create, :index] do
    collection do
      put :accept_request
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
