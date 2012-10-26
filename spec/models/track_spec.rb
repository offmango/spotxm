require 'spec_helper'
require 'time'

describe Track do

	now = Time.parse("2012-10-22 12:45:54")
	timestamp_data = Nokogiri::HTML("<html><body></body></html>")
	track_array = 	[
						{
							track_name: "Atlantic City",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							played_at: now,
							channel_number: 20,
							channel_name: "E Street Radio"
						},
						{
							track_name: "Don't Stop Believin'",
							artist_name: "Journey",
							album_name: "Greatest Hits",
							played_at: now,
							channel_number: 8,
							channel_name: "80's on 8"
						},
						{
							track_name: "My Dog Done Got Shot",
							artist_name: "Garth Brooks",
							channel_number: 33,
							album_name: "Songs About My Dog",
							played_at: now,
							channel_name: "Country Bumpkin"
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

	context "#save_current_playlist" do
		it "saves the array of tracks now playing to the database" do
			Track.all.each {|track| track.delete }
			Track.stubs(:now_playing).returns(track_array)

			Track.save_current_playlist

			tracks = Track.all
			tracks.size.should == 3
			tracks.should include(Track.find_by_track_name("Atlantic City"))
			tracks.should include(Track.find_by_track_name("Don't Stop Believin'"))
			tracks.should include(Track.find_by_track_name("My Dog Done Got Shot"))
		end

		it "does not save the now playing track for a channel if that is the most recent saved song for that channel" do
			Track.all.each {|track| track.delete }
			Track.create({
							track_name: "Nebraska",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							channel_number: 20, 
							channel_name: "E Street Radio",
							played_at: now - 300
						})
			Track.create({
							track_name: "Magic",
							artist_name: "The Cars",
							album_name: "The Cars Greatest Hits",
							channel_number: 8, 
							channel_name: "80's on 8",
							played_at: now - 200
						})			
			Track.create({
							track_name: "Atlantic City",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							channel_number: 20, 
							channel_name: "E Street Radio",
							played_at: now
						})
			Track.stubs(:now_playing).returns(track_array)

			Track.save_current_playlist

			tracks = Track.all
			tracks.size.should == 5
			atlantic_city = Track.find_by_track_name("Atlantic City")
			tracks.should include(Track.find_by_track_name("Don't Stop Believin'"))
			tracks.should include(Track.find_by_track_name("My Dog Done Got Shot"))

		end
	end

end