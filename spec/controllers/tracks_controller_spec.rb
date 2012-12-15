require 'spec_helper'

describe TracksController do 
	context '#index' do
    	it 'responds successfully' do
      		get :index
      		should respond_with(:success)
    	end

    	it 'lists tracks that meet the given search parameters' do
    		Track.all.each {|track| track.delete}

    		track1 = Track.create(channel_id: 1, track_name: "Neil's Song", album_name: "Some Album", artist_name: "Jo Shmo")
    		track2 = Track.create(channel_id: 2, track_name: "Some Song", album_name: "Neil Diamond Covers", artist_name: "Jane Shmo")
    		track3 = Track.create(channel_id: 3, track_name: "Another Song", album_name: "Another Album", artist_name: "Neil Diamond")
    		track4 = Track.create(channel_id: 1, track_name: "A Bad Song", album_name: "A Bad Album", artist_name: "Jimmy Shmo")

    		params = {track: {track_params: "neil"}}

            Track.stubs(:search).with(params[:track][:track_params]).returns([track1, track2, track3])

    		get :index, params

            Track.should have_received(:search).with(params[:track][:track_params])

			found_tracks = controller.instance_variable_get(:@tracks)
			found_tracks.should include(track1)
			found_tracks.should include(track2)
			found_tracks.should include(track3)
			found_tracks.should_not include(track4)
    	end
    end
end