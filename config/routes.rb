Rails.application.routes.draw do
  get '/config_game/get', to: 'config_game#get'
end
