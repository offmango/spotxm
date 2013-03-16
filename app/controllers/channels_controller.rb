class ChannelsController < ApplicationController
  
	def index
    	@channels = Channel.all.sort_by(&:channel_number)
	end

	def show
		@channel = Channel.find(params[:id])
		@tracks = @channel.tracks.page params[:page]
	end

    def now_playing
        Track.save_current_playlist
        @tracks = Track.most_recent.sort { |x, y| x.channel.channel_number <=> y.channel.channel_number }
    end

end