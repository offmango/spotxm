class TracksController < ApplicationController

	def index
		if params[:search].present? #and params[:search][:search_params].present?
			@search_params = params[:search][:search_params]
		 	results = Track.build_sunspot_query(params[:search]).results
		 	@tracks = Kaminari.paginate_array(results).page(params[:page])
		 	flash.now[:track_alert] = "No tracks found for '#{@search_params}'" if @tracks.blank?
		 	@channels = Channel.channel_search(params[:search][:search_params])
		 	flash.now[:channel_alert] = "No channels found for '#{@search_params}'" if @channels.blank?		 	
		else
			flash.now[:alert] = "It looks like you didn't search for anything, so here are the most recent tracks played."
			@tracks = Kaminari.paginate_array(Track.most_recent).page(params[:page])
		end
	end


	def search

	end

end

