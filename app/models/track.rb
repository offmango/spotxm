class Track < ActiveRecord::Base

	attr_accessible :track_name, :artist_name, :album_name, :channel_name, :channel_number, :played_at
	
	belongs_to :channel

	# Pagination
	paginates_per 25

	# For Solr
	searchable do
		# fields
		text :track_name
		text :artist_name
		text :album_name
		time :played_at
	end


	def self.now_playing(time = Time.now)
		timestamp_data = XMWrapper.get_timestamp
		return {} if timestamp_data.kind_of?(String)
		convert_timestamp_to_tracks(timestamp_data)
	end
	
	def self.save_current_playlist
		track_hashes = Track.now_playing
		track_hashes.each {|track_hash| process_track_hash(track_hash)}
	end

	def self.most_recent
		Track.search { with(:played_at).greater_than(Time.now - 3.minutes) }.results
		# most_recent_tracks = []
		# Channel.all.each do |channel| 
		# 	most_recent_track = channel.most_recent_track
		# 	most_recent_tracks << most_recent_track if most_recent_track.present?
		# end
		# most_recent_tracks
	end

	def self.build_sunspot_query(params)
		conditions = Track.build_search_conditions(params)
  		condition_procs = conditions.map{|c| Track.build_condition c}
  		Sunspot.search(Track) do
    		condition_procs.each{|c| instance_eval &c}
  		end
	end

	def self.build_search_conditions(params)
		conditions = []
		conditions << { fulltext: params[:search_params] } if params[:search_params].present?
		conditions << { start_time: Time.strptime(params[:start_time], "%m/%d/%Y %I:%M:%S %p") } if params[:start_time].present?
		conditions << { end_time: Time.strptime(params[:end_time], "%m/%d/%Y %I:%M:%S %p") } if params[:end_time].present?
		conditions
	end

	def self.build_condition(condition)
		case 
		when condition.has_key?(:fulltext)
  			Proc.new do
    			fulltext condition[:fulltext]
    		end
    	when condition.has_key?(:start_time)
    		Proc.new do
    			with(:played_at).greater_than condition[:start_time]
    		end
    	when condition.has_key?(:end_time)
    		Proc.new do
    			with(:played_at).less_than condition[:end_time]
    		end
  		end
	end

	def self.build_search_block(conditions)


		# results = Track.search { 
		#  							fulltext params[:search][:search_params] 
		#  							with(:played_at).greater_than params[:search][:start_time].to_time
		#  							with(:played_at).less_than params[:search][:end_time].to_time
		#  							}.results
	end



	private

	def self.process_track_hash(track_hash)
		channel = Channel.find_by_channel_number(track_hash[:channel_number])
		if channel.present?
			channel.tracks.create(track_hash) if new_track?(channel, track_hash)
		else
			channel = Channel.create({
				channel_number: track_hash[:channel_number],
				channel_name: track_hash[:channel_name]
			})
			channel.tracks.create(track_hash)
		end	
	end
	
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

	def self.convert_pad_data_to_tracks(timestamp_data)
		# this converts the old pad data call, which no longer works
		track_hashes = []
		channels = timestamp_data.css("event")
		channels.each do |channel|
			track = {
						artist_name: channel.at_css("artist").text,
						track_name: channel.at_css("songtitle").text,
						album_name: channel.at_css("album").text,
						channel_name: channel.at_css("channelname").text,
						channel_number: channel.at_css("channelnumber").text,
						played_at: Time.now
					}
			track_hashes << track
		end
		track_hashes.sort_by{|track| track[:channel_number]}
	end


	def self.new_track?(channel, track_hash)	
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
