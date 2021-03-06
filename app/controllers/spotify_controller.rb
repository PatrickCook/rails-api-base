class SpotifyController < ApplicationController
  def dashboard
    @top_artists = @spotify_user.top_artists(limit: 30, time_range: "long_term")
    @top_tracks = @spotify_user.top_tracks(limit: 30, time_range: "long_term")
    genres = @top_artists.map { |a| a.genres }.flatten.group_by(&:itself).transform_values(&:count).to_a
    @top_genres = genres.sort_by(&:last).reverse.map(&:first).slice(0,10)
    @recently_played = @spotify_user.recently_played(limit: 50).sort_by(&:played_at)
  end

  def play_history
    @play_history = @current_user.played_tracks.sort_by(&:played_at).reverse
  end

  def recently_played
    @recently_played = @spotify_user.recently_played(limit: 50)
  end

  def refresh_recently_played
    after = fetch_after_timestamp
    recently_played = @spotify_user.recently_played(limit: 50, after: after)
    recently_played.each do |track|
      artists = track.artists.map(&:name).join(", ")
      @current_user.played_tracks.create(name: track.name, artists: artists, uri: track.uri, played_at: track.played_at)
    end

    respond_to do |format|
      format.html do
        redirect_to spotify_play_history_path
      end

      format.json do
        render json: { action: "add_recently_played", status: "success", added_tracks: recently_played.count }
      end
    end
  end

  def generate_top_songs_playlist
    top_tracks = @spotify_user.top_tracks(limit: 30, time_range: params["time_range"])
    playlist = @spotify_user.create_playlist!("Spotify Automator: Top Tracks (#{params["time_range"]})")

    playlist.add_tracks!(top_tracks)
    flash[:notice] = "Playlist successfully created"
    redirect_to spotify_dashboard_path
  end

  def generate_top_artists_playlist

  end

  private

  def fetch_after_timestamp
    max_timestamp = @current_user.played_tracks.maximum("played_at")
    timestamp_to_milliseconds(max_timestamp)
  end

  def timestamp_to_milliseconds(timestamp)
    return 0 unless timestamp

    (timestamp.to_f * 1000).to_i
  end
end
