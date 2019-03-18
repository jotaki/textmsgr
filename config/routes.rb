Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get /
  root 'application#index'

  # post /text
  post '/text', to: 'application#sendtext'
end
