class Track

	def self.now_playing(time = Time.now)
		timestamp_data = XMWrapper.get_timestamp
		convert_timestamp_to_tracks(timestamp_data)
	end

	private

	def self.convert_timestamp_to_tracks(timestamp_array)
		track_array = []
		timestamp_array.each do |channel|
			channel_name = channel.at_css("channelname").text
			channel_number = channel.at_css("channelnumber").text
			track = channel.css("currentevent")
			artist_name = track.at_css("artists name").text
			album_name = track.at_css("album name").text
			track_name = track.css("name").last.text
			track =	{
						track_name: track_name, 
						artist_name: artist_name, 
						album_name: album_name, 
						channel_name: channel_name, 
						channel_number: channel_number.to_i, 
						played_at: Time.now
					}
			track_array << track
		end
		track_array.sort_by{|track| track[:channel_number]}
	end

end
