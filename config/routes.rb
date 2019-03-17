Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get /
  root 'application#login'

  # post /login
  post '/login', to: 'application#post_login'
end
