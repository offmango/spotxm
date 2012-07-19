require 'spec_helper'

describe ChannelsController, '#index' do 
  context 'no params' do
    it 'responds successfully' do
      get :index
      should respond_with(:success)
    end
  end

  context 'with params channel name' do
    it 'redirects me to channel show' do
      get :index#, {:channel=>{:name=>'name'}}
      response.should be_redirect 
    end
  end

end