class ChannelsController < ApplicationController
  
	def index  
    if params[:channel].present? and params[:channel][:name].present?
    #  redirect_to channel_path(params[:channel][:name])
    end
	end

  def show
  end

  def find_channel
  	redirect_to channels_path(params[:channel][:name])
  end 
  
end