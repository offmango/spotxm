class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :track_name
      t.string :artist_name
      t.string :album_name
      t.string :channel_name
      t.integer :channel_number
      t.datetime :played_at

      t.timestamps
    end
  end
end
