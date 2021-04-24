Rails.application.routes.draw do
  get '/config_game/get', to: 'config_game#get'
  put '/config_game/update', to: 'config_game#update'
end
