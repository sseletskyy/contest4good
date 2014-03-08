Contest4good::Application.routes.draw do
  devise_for :users,
             :controllers => {:sessions => "u/sessions", :invitations => "u/invitations"}, :path => '',
             :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             skip: [:registration, :password]
  resources :users, only: [:new, :create]

  namespace :u do
    resources :user_profiles
    get "home/index"
  end


  get "home/index"
  root :to => "home#index"
end
