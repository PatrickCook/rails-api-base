class CreatePlayedTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :played_tracks do |t|
      t.references :user
      t.string :uri
      t.string :name
      t.string :artists
      t.timestamp :played_at
      t.timestamps
    end
  end
end
