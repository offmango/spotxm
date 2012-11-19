class AddChannelIdToTracks < ActiveRecord::Migration
  def change
  	add_column :tracks, :channel_id, :integer
  end
end
