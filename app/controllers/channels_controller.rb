class ChannelsController < ApplicationController
  
	def index
    	if params[:channel].present? and params[:channel][:channel_number].present?
    		@channel = Channel.find_by_channel_number(params[:channel][:channel_number])
    		if @channel.present?	
    			redirect_to channel_path(@channel) 
    		else
    			flash[:alert] = "Channel #{params[:channel][:channel_number]} not found"
    		end
        else
            @tracks = Track.most_recent.sort { |x, y| x.channel.channel_number <=> y.channel.channel_number }
        end
	end

	def show
		@channel = Channel.find(params[:id])
		@tracks = @channel.tracks
	end

end