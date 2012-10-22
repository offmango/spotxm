require 'spec_helper'
require 'time'

describe Track do

	Time.stubs(:now).returns(Time.parse("2012-10-22 12:45:54"))
	timestamp_data = Nokogiri::HTML("<html><body></body></html>")
	track_array = 	[
						{
							track_name: "Atlantic City",
							artist_name: "Bruce Springsteen",
							channel_number: 20
						},
						{
							track_name: "Don't Stop Believin'",
							artist_name: "Journey",
							channel_number: 8
						},
						{
							track_name: "My Dog Done Got Shot",
							artist_name: "Country Bumpkin",
							channel_number: 33
						}
					]


	context "#now_playing" do
		it "returns an array of tracks now playing on all channels" do
			XMWrapper.stubs(:get_timestamp).returns(timestamp_data)
			Track.stubs(:convert_timestamp_to_tracks).with(timestamp_data).returns(track_array)

			tracks = Track.now_playing

			XMWrapper.should have_received(:get_timestamp).once
			Track.should have_received(:convert_timestamp_to_tracks).with(timestamp_data).once
			tracks.should == track_array
		end
	end
end