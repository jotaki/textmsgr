Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get /
  root 'application#index'

  # post /text
  post '/text', to: 'application#sendtext'

  # post incoming_text
  post '/incoming_text', to: 'application#incoming_text'

  # get /text
  get '/text', to: 'application#index'
end
