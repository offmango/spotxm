class TracksController < ApplicationController

	def index
		if params[:search].present? and params[:search][:search_params].present?
			@search_params = params[:search][:search_params]
		 	@tracks = Track.search { fulltext params[:search][:search_params] }.results
		 	flash[:track_alert] = "No tracks found for '#{@search_params}'" if @tracks.blank?
		 	@channels = Channel.search { fulltext params[:search][:search_params] }.results
		 	flash[:channel_alert] = "No channels found for '#{@search_params}'" if @channels.blank?		 	
		else
			@tracks = Track.most_recent
		end
		# if params[:track].present? and params[:track][:track_params].present?
		# 	@search_params = params[:track][:track_params]
		# 	@tracks = Track.search { fulltext params[:track][:track_params] }.results
		# 	flash[:alert] = "Track '#{params[:track][:track_params]}' not found" if @tracks.blank?
		# else
		# 	@tracks = Track.all
		# end
	end


	def search

	end

end
