Rails.application.routes.draw do
  get 'spotify/index'

  root 'welcome#index'

  post 'authenticate', to: 'authentication#authenticate'
  get '/auth/spotify/callback', to: 'authentication#spotify'

end
