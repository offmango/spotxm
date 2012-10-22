class ChannelsController < ApplicationController
  
	def index
		@tracks = Track.now_playing  
    	if params[:channel].present? and params[:channel][:number].present?
    		# @channel_name = params[:channel][:name]		
    	end
	end

end