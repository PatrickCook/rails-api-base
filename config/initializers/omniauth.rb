require 'rspotify/oauth'

Rails.application.config.to_prepare do
  OmniAuth::Strategies::Spotify.include SpotifyOmniauthExtension
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "988ae7afb59749a9a5d359c27767bd78", "47c2a53a79474ff49eed9e52b192a216",
           scope: 'user-read-recently-played user-top-read user-read-email playlist-modify-public playlist-modify-private user-library-read user-library-modify'
end
