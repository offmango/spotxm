class Channel < ActiveRecord::Base
  attr_accessible :channel_name, :channel_number, :description

  has_many :tracks, :order => "played_at DESC"

  def most_recent_track
  	self.tracks.first
  end

end
