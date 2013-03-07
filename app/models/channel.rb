class Channel < ActiveRecord::Base
	attr_accessible :channel_name, :channel_number, :description

  	has_many :tracks, :order => "played_at DESC"

	# For Solr
	searchable do
		# fields
		text :channel_name
		integer :channel_number
	end

  	def self.channel_search(params)
  		channel_search = Channel.search do
		 	if params.to_i != 0
		 		with :channel_number, params.to_i
		 	else
		 		fulltext params
		 	end
		end
		channel_search.results
	end

	def most_recent_track
  		self.tracks.first
  	end

end
