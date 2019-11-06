require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "988ae7afb59749a9a5d359c27767bd78", "47c2a53a79474ff49eed9e52b192a216", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
