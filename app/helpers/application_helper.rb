module ApplicationHelper

	require 'open-uri'

	def spotify_track_link(track_hash)
		if track_hash[:artist_name].present?
			"http://open.spotify.com/search/title:#{URI.escape(track_hash[:track_name])}%20artist:#{URI.escape(track_hash[:artist_name])}"
		else
			"http://open.spotify.com/search/title:#{URI.escape(track_hash[:track_name])}"
		end
	end

	def spotify_link(link_type, track)
		case link_type
		when "artist"
			"http://open.spotify.com/search/artist:#{URI.escape(track[:artist_name])}"
		when "title"
			"http://open.spotify.com/search/title:#{URI.escape(track[:track_name])}%20artist:#{URI.escape(track[:artist_name])}"
		when "album"
			"http://open.spotify.com/search/album:#{URI.escape(track[:album_name])}%20artist:#{URI.escape(track[:artist_name])}"
		end
	end



end
