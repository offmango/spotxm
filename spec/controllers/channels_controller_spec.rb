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

    
  end

end