require 'spec_helper'
require 'open-uri'

describe ApplicationHelper do

	context "#spotify_link" do
		it "creates spotify artist search link if given search type is artist" do
			track = {artist_name: "Bruce Springsteen"}

			spot_link = spotify_link("artist", track)

			spot_link.should == "http://open.spotify.com/search/artist:Bruce%20Springsteen"
		end

		it "creates spotify title search link if search type is title" do
			track = {
						track_name: 	"Where the Bands Are",
						artist_name: 	"Bruce Springsteen"
					}

			spot_link = spotify_link("title", track)

			spot_link.should == "http://open.spotify.com/search/title:Where%20the%20Bands%20Are%20artist:Bruce%20Springsteen"
		end

		it "creates spotify album search link if search type is album" do
			track = {
						album_name: "Darkness on the Edge of Town",
						artist_name: "Bruce Springsteen"
					}

			spot_link = spotify_link("album", track)

			spot_link.should == "http://open.spotify.com/search/album:Darkness%20on%20the%20Edge%20of%20Town%20artist:Bruce%20Springsteen"
		end

	end

end
