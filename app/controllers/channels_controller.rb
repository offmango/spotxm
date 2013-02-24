class ChannelsController < ApplicationController
  
	def index
    	if params[:channel].present? and params[:channel][:channel_params].present?
    		@channels = Channel.search { fulltext params[:channel][:channel_params] }.results
    		if @channels.present?	
    			redirect_to channel_path(@channels.first) 
    		else
    			flash[:alert] = "Channel #{params[:channel][:channel_params]} not found"
    		end
        else
            @tracks = Track.most_recent.sort { |x, y| x.channel.channel_number <=> y.channel.channel_number }
        end
	end

	def show
		@channel = Channel.find(params[:id])
		@tracks = @channel.tracks
	end

    def now_playing
        Track.save_current_playlist
        @tracks = Track.most_recent.sort { |x, y| x.channel.channel_number <=> y.channel.channel_number }
    end

end