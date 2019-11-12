Rails.application.routes.draw do
  root 'welcome#index'

  post 'authenticate', to: 'authentication#authenticate'
  get '/auth/spotify/callback', to: 'authentication#spotify'

  get 'spotify/dashboard'
  get 'spotify/play_history'
  get 'spotify/recently_played'
  get 'spotify/add_recently_played'
end
