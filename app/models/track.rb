class Track

	include MongoMapper::Document

  	key :track_name, String
  	key :artist_name, String
  	key :album_name, String
  	key :channel_name, String
  	key :channel_number,  Integer
  	key :played_at, Time

	def self.now_playing(time = Time.now)
		timestamp_data = XMWrapper.get_timestamp
		convert_timestamp_to_tracks(timestamp_data)
	end

	def self.save_current_playlist
		tracks = Track.now_playing
		tracks.each {|track| Track.create(track) if new_track?(track)}
	end

	private

	def self.convert_timestamp_to_tracks(timestamp_array)
		tracks = []
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
			tracks << track
		end
		tracks.sort_by{|track| track[:channel_number]}
	end

	def self.new_track?(track_hash)
		last_track = Track.find_all_by_channel_number(track_hash[:channel_number]).last
		if last_track.blank?
			return true
		else
			last_track.track_name != track_hash[:track_name] or
			last_track.artist_name != track_hash[:artist_name] or
			last_track.album_name != track_hash[:album_name]
		end
	end

end
