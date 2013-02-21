class TracksController < ApplicationController

	def index
		if params[:track].present? and params[:track][:track_params].present?
			@search_params = params[:track][:track_params]
			@tracks = Track.search {fulltext @search_params }.results	
		else
			@tracks = Track.all
		end
	end


end
