class ChannelsController < ApplicationController
  
	def index
    	@tracks = Track.most_recent
    	if params[:channel].present? and params[:channel][:channel_number].present?
    		@channel = Channel.find_by_channel_number(params[:channel][:channel_number])
    		redirect_to channel_path(@channel) if @channel.present?		
    	end
	end

	def show
		@channel = Channel.find(params[:id])
		@tracks = @channel.tracks
	end

end