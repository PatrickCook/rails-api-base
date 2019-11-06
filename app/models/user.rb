class User < ApplicationRecord
  has_secure_password

  serialize :spotify_hash, Hash
end
