Rails.application.routes.draw do
  resources :categories

  # Defines the root path route ("/")
  root "events#index"

  get "events/filter/:filter" => "events#index", as: :filtered_events

  resources :events do 
    resources :registrations
    resources :likes
  end
  
  resources :users
  get "signup" => "users#new"

  resource :session, only: [:new, :create, :destroy]

  # namespace :admin do
  #   resources :articles, :comments
  # end
  
  # scope module: 'admin' do
  #   resources :articles, :comments
  # end
  
  # scope '/admin' do
  #   resources :articles, :comments
  # end
  

  # scope 'admin' do
  #   resources :photos, as: 'admin_photos'
  # end
  

  # get "events" => "events#index"
  # get "events/new" => "event#new"
   # get "events/:id" => "events#show", as: "event"
  # get "events/:id/edit" => "events#edit", as: "edit_event"
  # patch "events/:id" => "events#update"
end
