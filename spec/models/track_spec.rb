require 'spec_helper'
require 'time'

describe Track do

	now = Time.parse("2012-10-22 12:45:54")
	timestamp_data = Nokogiri::HTML("<html><body></body></html>")

	array_of_track_hashes = [
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
		it "returns an array of track hashes now playing on all channels" do
			XMWrapper.stubs(:get_timestamp).returns(timestamp_data)
			Track.stubs(:convert_timestamp_to_tracks).with(timestamp_data).returns(array_of_track_hashes)

			tracks = Track.now_playing

			XMWrapper.should have_received(:get_timestamp).once
			Track.should have_received(:convert_timestamp_to_tracks).with(timestamp_data).once
			tracks.should == array_of_track_hashes
		end
	end

	context "#save_current_playlist" do
		it "saves the array of track_hashes now playing to the database as tracks" do
			Track.all.each {|track| track.delete }
			Track.stubs(:now_playing).returns(array_of_track_hashes)

			Track.save_current_playlist

			tracks = Track.all
			tracks.size.should == 3
			tracks.should include(Track.find_by_track_name("Atlantic City"))
			tracks.should include(Track.find_by_track_name("Don't Stop Believin'"))
			tracks.should include(Track.find_by_track_name("My Dog Done Got Shot"))
		end

		it "does not save the now playing track for a channel if that is the most recent saved song for that channel" do
			Channel.all.each {|channel| channel.delete}
			bruce_channel = Channel.create({
				channel_name: "E Street Radio",
				channel_number: 20
			})
			eighties_channel = Channel.create({
				channel_name: "80's on 8",
				channel_number: 8
			})
			country_channel = Channel.create({
				channel_name: "Country Bumpkin",
				channel_number: 33
			})

			Track.all.each {|track| track.delete }
			bruce_channel.tracks.create({
				track_name: "Nebraska",
				artist_name: "Bruce Springsteen",
				album_name: "Darkness on the Edge of Town",
				played_at: now - 300
			})
			eighties_channel.tracks.create({
				track_name: "Magic",
				artist_name: "The Cars",
				album_name: "The Cars Greatest Hits",
				played_at: now - 200
			})			
			bruce_channel.tracks.create({
				track_name: "Atlantic City",
				artist_name: "Bruce Springsteen",
				album_name: "Darkness on the Edge of Town",
				played_at: now
			})
			Track.stubs(:now_playing).returns(array_of_track_hashes)

			Track.save_current_playlist

			tracks = Track.all
			tracks.size.should == 5
			tracks.should include(Track.find_by_track_name("Don't Stop Believin'"))
			tracks.should include(Track.find_by_track_name("My Dog Done Got Shot"))

		end

		it "creates the necessary channel if it finds a track for a channel that does not yet exist" do
			pending "OH YEAH"
		end
	end

	context "#most_recent" do
		it "returns the most recent track played on every channel" do
			Channel.all.each {|channel| channel.delete }

			bruce_channel = Channel.create({
								channel_name: "E Street Radio",
								channel_number: 20
			})
			eighties_channel = Channel.create({
								channel_name: "80's on 8",
								channel_number: 8
			})
			country_channel = Channel.create({
								channel_name: "Country Bumpkin",
								channel_number: 33
			})
			unused_channel = Channel.create({
								channel_name: "This channel is old",
								channel_number: 99
			})

			Track.all.each {|track| track.delete }

			nebraska = bruce_channel.tracks.create({
							track_name: "Nebraska",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							channel_name: "E Street Radio",
							played_at: now - 300
						})
			magic = eighties_channel.tracks.create({
							track_name: "Magic",
							artist_name: "The Cars",
							album_name: "The Cars Greatest Hits",
							channel_name: "80's on 8",
							played_at: now - 200
						})			
			atlantic_city = bruce_channel.tracks.create({
							track_name: "Atlantic City",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							channel_name: "E Street Radio",
							played_at: now
						})
			dog = country_channel.tracks.create({
							track_name: "My Dog Done Got Shot",
							artist_name: "Garth Brooks",
							album_name: "Songs About My Dog",
							played_at: now - 500,
							channel_name: "Country Bumpkin"
			})

			Channel.stubs(:all).returns([bruce_channel, eighties_channel, country_channel, unused_channel])
			bruce_channel.stubs(:most_recent_track).returns(atlantic_city)
			eighties_channel.stubs(:most_recent_track).returns(magic)
			country_channel.stubs(:most_recent_track).returns(dog)
			unused_channel.stubs(:most_recent_track).returns(nil)

			most_recent_tracks = Track.most_recent

			bruce_channel.should have_received(:most_recent_track)
			eighties_channel.should	have_received(:most_recent_track)
			country_channel.should have_received(:most_recent_track)
			unused_channel.should have_received(:most_recent_track)

			most_recent_tracks.size.should == 3
			most_recent_tracks.should include(magic)
			most_recent_tracks.should include(dog)
			most_recent_tracks.should include(atlantic_city)
		end
	end


end