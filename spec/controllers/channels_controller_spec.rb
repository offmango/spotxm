require 'spec_helper'

describe ChannelsController do 
	context '#index' do
    	it 'responds successfully' do
      		get :index
      		should respond_with(:success)
    	end

    	it 'redirects to a specific channel page if a valid channel number has been searched for' do
    		channel = Channel.create(channel_number: 20)
    		Channel.stubs(:find_by_channel_number).returns(channel)

    		params = {:channel => {:channel_number => 20}}
    		get :index, params
    		
    		should redirect_to channel_path(channel)
    	end

    	it 'returns the most recent tracks played ordered by channel number' do
    		channel1 = Channel.create(channel_number: 1)
    		channel5 = Channel.create(channel_number: 5)
    		channel10 = Channel.create(channel_number: 10)
    		channel100 = Channel.create(channel_number: 100)

    		track1 = channel1.tracks.create
    		track5 = channel5.tracks.create
    		track10 = channel10.tracks.create
    		track100 = channel100.tracks.create

    		Track.stubs(:most_recent).returns([track5, track100, track10, track1])

    		get :index

      	tracks_collection = controller.instance_variable_get(:@tracks) 

      	tracks_collection.should == [track1, track5, track10, track100]
      end
  	end

end