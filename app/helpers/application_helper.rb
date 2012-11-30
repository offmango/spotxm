module ApplicationHelper

	require 'cgi'

	def spotify_link(link_type, track_hash)
		hash_key = "#{link_type}_name".to_sym
		"spotify:search:#{link_type}:#{CGI.escape(track_hash[hash_key])}"
	end



end
