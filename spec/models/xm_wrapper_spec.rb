require 'spec_helper'
require 'time'
require 'nokogiri'

describe XMWrapper do

	Time.stubs(:now).returns(Time.parse("2012-10-22 12:45:54"))
	#time_in_url = "10-22-16:45:44"
	#timestamp_url = "https://www.siriusxm.com/metadata/pdt/en-us/xml/events/timestamp/10-22-16:45:44"
	#timestamp_data = Nokogiri::HTML("<html><body></body></html>")
	# array_of_songs = [
	# 					{
	# 						song_name: "Atlantic City",
	# 						artist_name: "Bruce Springsteen",
	# 						channel_name: "E Street Radio"
	# 					},
	# 					{
	# 						song_name: "Don't Stop Believin'",
	# 						artist_name: "Journey",
	# 						channel_name: "Totally 80's"
	# 					},
	# 					{
	# 						song_name: "My Dog Done Got Shot",
	# 						artist_name: "Country Bumpkin",
	# 						channel_name: "All Country All the Time"
	# 					}
	# 				]
	
	context "#get_timestamp" do
		it "returns the data from a sirius xm timestamp request" do
			pending "argh"
		end
	end


	# context "#currently_playing" do
	# 	it "returns an array of hashes of everything currently playing on Sirius XM" do
	# 		XMWrapper.stubs(:get_timestamp_url).with(now).returns(timestamp_url)
	# 		XMWrapper.stubs(:get_timestamp_data).with(timestamp_url).returns(timestamp_data)
	# 		XMWrapper.stubs(:hashify_timestamp_data).with(timestamp_data).returns(array_of_songs)

	# 		currently_playing_array = XMWrapper.currently_playing(now)

	# 		XMWrapper.should have_received(:get_timestamp_url).with(now).once
	# 		XMWrapper.should have_received(:get_timestamp_data).with(timestamp_url).once
	# 		XMWrapper.should have_received(:hashify_timestamp_data).with(timestamp_data).once
	# 		array_of_songs.should == currently_playing_array
	# 	end
	# end

	# context "#find_current_song_by_channel_name" do
	# 	it "returns a hash of the currently playing song on the given channel" do
	# 		pending "oh man"
	# 	end
	# end

	# context "#get_timestamp_url" do
	# 	it "returns a properly formatted url for getting the Sirius XM timestamp" do
	# 		XMWrapper.stubs(:convert_time_for_url).with(now).returns(time_in_url)

	# 		url = XMWrapper.get_timestamp_url(now)

	# 		XMWrapper.should have_received(:convert_time_for_url).with(now)
	# 		url.should == timestamp_url
	# 	end
	# end
end
