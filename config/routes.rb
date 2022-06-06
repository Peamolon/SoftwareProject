Rails.application.routes.draw do
  get 'members/new'
  get 'members/create'
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  root 'home#index'
  resources :teams, only: [:index, :show, :new, :create, :destroy] do
    collection do
      put :remove_member
      post :join_with_password
    end
    get '*path' => redirect('/')
  end
  resources :team_invitations, only: [:new, :create, :index] do
    collection do
      put :accept_request
    end
    get '*path' => redirect('/')
  end
  resources :members, only: [:new, :create]

  get 'admin/members_info', to: 'admin#export', as: :export_data

  resources :admin, only: [:index] do
    collection do
      get '*path' => redirect('/')
    end

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
