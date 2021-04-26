Rails.application.routes.draw do
  get '/config_game/get', to: 'config_game#get'
  put '/config_game/update', to: 'config_game#update'
  post '/question/save', to: 'question#save'
  get '/question/show_recent', to: 'question#show_recent'
  get '/question/show_top', to: 'question#show_top'
  post '/score/save', to: 'score#save'
  get '/score/show_recent', to: 'score#show_recent'
  get '/score/show_top', to: 'score#show_top'
  get '/score/show_position', to: 'score#show_position'
end
