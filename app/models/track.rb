class Track < ActiveRecord::Base

	attr_accessible :track_name, :artist_name, :album_name, :channel_name, :channel_number, :played_at
	
	belongs_to :channel

	def self.now_playing(time = Time.now)
		timestamp_data = XMWrapper.get_timestamp
		convert_timestamp_to_tracks(timestamp_data)
	end
	
	def self.save_current_playlist
		track_hashes = Track.now_playing
		track_hashes.each {|track_hash| Track.create(track_hash) if new_track?(track_hash)}
	end

	def self.most_recent
		most_recent_tracks = []
		Channel.all.each do |channel| 
			most_recent_track = channel.most_recent_track
			most_recent_tracks << most_recent_track if most_recent_track.present?
		end
		most_recent_tracks
	end


	private

	
	def self.convert_timestamp_to_tracks(timestamp_array)
		track_hashes = []
		timestamp_array.each do |channel|
			channel_name = channel.at_css("channelname").text
			channel_number = channel.at_css("channelnumber").text
			track_info = channel.css("currentevent")
			track =	{
						track_name: track_info.css("name").last.text, 
						artist_name: track_info.at_css("artists name").text, 
						album_name: track_info.at_css("album name").text, 
						channel_name: channel_name, 
						channel_number: channel_number.to_i, 
						played_at: Time.now
					}
			track_hashes << track
		end
		track_hashes.sort_by{|track| track[:channel_number]}
	end

	def self.new_track?(track_hash)
		channel = Channel.find_by_channel_number(track_hash[:channel_number])
		last_track = channel.tracks.first
		if last_track.blank?
			return true
		else
			last_track.track_name != track_hash[:track_name] or
			last_track.artist_name != track_hash[:artist_name] or
			last_track.album_name != track_hash[:album_name]
		end
	end

end
