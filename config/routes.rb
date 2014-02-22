Contest4good::Application.routes.draw do
  get "home/index"
  root :to => "home#index"
end
