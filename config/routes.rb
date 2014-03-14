Contest4good::Application.routes.draw do

  devise_for :admins,
             :controllers => {:sessions => "a/sessions", :invitations => "a/invitations"},
             :path => 'a',
             :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             skip: [:registration, :password]

  devise_for :users,
             :controllers => {:sessions => "u/sessions", :invitations => "u/invitations"},
             :path => 'u',
             :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             skip: [:registration, :password]

  namespace :u do
    resource :user_profile, :controller => "user_profiles", only: [:edit, :update, :show]
    get '/', to: 'home#index', as: 'home'
  end

  namespace :a do
    resource :admin_profile, :controller => "admin_profiles", only: [:edit, :update, :show]
    resources :admin_profiles, :controller => "admin_profiles", only: [:index]
    get '/', to: 'home#index', as: 'home'
    resources :contests
  end


  get "home/index"
  root :to => "home#index"
end
