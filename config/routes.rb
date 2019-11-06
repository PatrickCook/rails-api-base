Rails.application.routes.draw do
  root 'welcome#index'

  post 'authenticate', to: 'authentication#authenticate'
  get '/auth/spotify/callback', to: 'authentication#spotify'

end
