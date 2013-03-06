require 'spec_helper'

describe TracksController do 

    before :each do
        Track.all.each { |track| track.delete }
        Channel.all.each { |channel| channel.delete }
    end

	context '#index' do
    	it 'responds successfully' do
      		get :index
      		should respond_with(:success)
    	end

    	it 'lists tracks that meet the given search parameters' do
    		track1 = Track.create(channel_id: 1, track_name: "Neil's Song", album_name: "Some Album", artist_name: "Jo Shmo")
    		track2 = Track.create(channel_id: 2, track_name: "Some Song", album_name: "Neil Diamond Covers", artist_name: "Jane Shmo")
    		track3 = Track.create(channel_id: 3, track_name: "Another Song", album_name: "Another Album", artist_name: "Neil Diamond")
    		track4 = Track.create(channel_id: 1, track_name: "A Bad Song", album_name: "A Bad Album", artist_name: "Jimmy Shmo")

    		params = {search: {search_params: "neil"}}
            search_result = OpenStruct.new(results: [track1, track2, track3])

            Track.stubs(:search).returns(search_result)

    		get :index, params

            Track.should have_received(:search)

			found_tracks = controller.instance_variable_get(:@tracks)
			found_tracks.should include(track1)
			found_tracks.should include(track2)
			found_tracks.should include(track3)
			found_tracks.should_not include(track4)
    	end

        it 'lists channels that meet the given search parameters' do
            xmu = Channel.create(channel_number: 35, channel_name: "Sirius XMU", description: "Alternative music for cool people")
            bruce = Channel.create(channel_number: 20, channel_name: "E Street Radio", description: "All Bruce, all the time")
            params = {search: {search_params: "35"}}
            search_result = OpenStruct.new(results: [xmu])

            Channel.stubs(:search).returns(search_result)

            get :index, params

            Channel.should have_received(:search)

            found_channels = controller.instance_variable_get(:@channels)
            found_channels.should include(xmu)
            found_channels.should_not include(bruce)
        end

        it 'lists both the tracks and channels found if a search parameter matches both a track and a channel' do
            track1 = Track.create(channel_id: 1, track_name: "Neil's Song", album_name: "Some Album", artist_name: "Jo Shmo")
            track2 = Track.create(channel_id: 2, track_name: "Some Song", album_name: "Neil Diamond Covers", artist_name: "Jane Shmo")
            track3 = Track.create(channel_id: 3, track_name: "Another Song", album_name: "Another Album", artist_name: "Neil Diamond")
            track4 = Track.create(channel_id: 1, track_name: "A Bad Song", album_name: "A Bad Album", artist_name: "Jimmy Shmo")

            xmu = Channel.create(channel_number: 35, channel_name: "Sirius XMU", description: "Alternative music for cool people")
            bruce = Channel.create(channel_number: 20, channel_name: "E Street Radio", description: "All Bruce, all the time")
            neil = Channel.create(channel_number: 44, channel_name: "Neil Diamond Radio", description: "You know you love Neil Diamond")

            params = {search: {search_params: "neil"}}
            track_search_result = OpenStruct.new(results: [track1, track2, track3])
            channel_search_result = OpenStruct.new(results: [neil])

            Track.stubs(:search).returns(track_search_result)
            Channel.stubs(:search).returns(channel_search_result)

            get :index, params

            Track.should have_received(:search)
            Channel.should have_received(:search)

            found_tracks = controller.instance_variable_get(:@tracks)
            found_tracks.should include(track1)
            found_tracks.should include(track2)
            found_tracks.should include(track3)
            found_tracks.should_not include(track4)

            found_channels = controller.instance_variable_get(:@channels)
            found_channels.should include(neil)
            found_channels.should_not include(bruce)
            found_channels.should_not include(xmu)
        end



        it 'lists the most recent track in the database for each channel if no parameters are given' do
            track1 = Track.create(channel_id: 1, track_name: "Neil's Song", album_name: "Some Album", artist_name: "Jo Shmo")
            track2 = Track.create(channel_id: 2, track_name: "Some Song", album_name: "Neil Diamond Covers", artist_name: "Jane Shmo")
            track3 = Track.create(channel_id: 3, track_name: "Another Song", album_name: "Another Album", artist_name: "Neil Diamond")
            track4 = Track.create(channel_id: 1, track_name: "A Bad Song", album_name: "A Bad Album", artist_name: "Jimmy Shmo")

            Track.stubs(:most_recent).returns([track2, track3, track4])

            get :index

            Track.should have_received(:search).never
            Channel.should have_received(:search).never

            tracks = controller.instance_variable_get(:@tracks)
            tracks.should include(track2)
            tracks.should include(track3)
            tracks.should include(track4)
            tracks.should_not include(track1)
        end


        it 'flashes an alert if no tracks are found' do
            neil = Channel.create(channel_number: 44, channel_name: "Neil Diamond Radio", description: "You know you love Neil Diamond")
            params = {search: {search_params: "neil"}}
            track_search_result = OpenStruct.new(results: [])
            channel_search_result = OpenStruct.new(results: [neil])

            Track.stubs(:search).returns(track_search_result)
            Channel.stubs(:search).returns(channel_search_result)
        
            get :index, params

            flash[:track_alert].should == "No tracks found for 'neil'"
            flash[:channel_alert].should be_nil
        end


        it 'flashes an alert if no channels are found' do
            track1 = Track.create(channel_id: 1, track_name: "Neil's Song", album_name: "Some Album", artist_name: "Jo Shmo")
            params = {search: {search_params: "neil"}}
            channel_search_result = OpenStruct.new(results: [])
            track_search_result = OpenStruct.new(results: [track1])
            Track.stubs(:search).returns(track_search_result)
            Channel.stubs(:search).returns(channel_search_result)
        
            get :index, params

            flash[:track_alert].should be_nil
            flash[:channel_alert].should == "No channels found for 'neil'"
        end

        it 'flashes alerts for both tracks and channels if neither are found' do
            params = {search: {search_params: "gobbledygook"}}
            channel_search_result = OpenStruct.new(results: [])
            track_search_result = OpenStruct.new(results: [])
            Track.stubs(:search).returns(track_search_result)
            Channel.stubs(:search).returns(channel_search_result)
        
            get :index, params

            flash[:track_alert].should == "No tracks found for 'gobbledygook'"
            flash[:channel_alert].should == "No channels found for 'gobbledygook'"
        end
    end


end