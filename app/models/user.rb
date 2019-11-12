class User < ApplicationRecord
  serialize :spotify_hash, Hash
  has_many :played_tracks, dependent: :destroy

  has_secure_password
end
