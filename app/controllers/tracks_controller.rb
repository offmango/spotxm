class TracksController < ApplicationController

	def index
		if params[:track].present? and params[:track][:track_params].present?
			@search_params = params[:track][:track_params]
			@tracks = Track.search { fulltext params[:track][:track_params] }.results
			flash[:alert] = "Track '#{params[:track][:track_params]}' not found" if @tracks.blank?
		else
			@tracks = Track.all
		end
	end


end
