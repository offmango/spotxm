require 'spec_helper'
require 'cgi'

describe ApplicationHelper do

	context "#spotify_link" do
		it "creates spotify artist search link if given search type is artist" do
			track = {artist_name: "Bruce Springsteen"}

			spot_link = spotify_link("artist", track)

			spot_link.should == "spotify:search:artist:Bruce+Springsteen"
		end

		it "creates spotify track search link if search type is title" do
			track = {
						track_name: 	"Where the Bands Are",
						artist_name: 	"Bruce Springsteen"
					}

			spot_link = spotify_link("track", track)

			spot_link.should == "spotify:search:track:Where+the+Bands+Are"
		end

		it "creates spotify album search link if search type is album" do
			track = {
						album_name: "Darkness on the Edge of Town",
						artist_name: "Bruce Springsteen"
					}

			spot_link = spotify_link("album", track)

			spot_link.should == "spotify:search:album:Darkness+on+the+Edge+of+Town"
		end

	end

end
