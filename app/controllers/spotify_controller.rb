class SpotifyController < ApplicationController
  def index
    @top_artists = @spotify_user.top_artists
    @top_tracks = @spotify_user.top_tracks
    genres = @top_artists.map { |a| a.genres }.flatten.group_by(&:itself).transform_values(&:count).to_a
    @top_genres = genres.sort_by(&:last).reverse.map(&:first).slice(0,10)
    @recently_played = @spotify_user.recently_played
  end
end
