require 'spec_helper'

describe Channel do
	context "#most_recent_track" do
		now = Time.parse("2012-10-22 12:45:54")

		it "finds the most recent track on the given channel" do

		  	Channel.all.each {|channel| channel.delete }

			bruce_channel = Channel.create({
								channel_name: "E Street Radio",
								channel_number: 20
			})

			some_other_channel = Channel.create({
								channel_name: "Some Other Channel",
								channel_number: 66
			})
			
			Track.all.each {|track| track.delete }

			the_river = bruce_channel.tracks.create({
							track_name: "The River",
							artist_name: "Bruce Springsteen",
							album_name: "The River",
							played_at: now - 2000
						})
			atlantic_city = bruce_channel.tracks.create({
							track_name: "Atlantic City",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							played_at: now
						})
			nebraska = bruce_channel.tracks.create({
							track_name: "Nebraska",
							artist_name: "Bruce Springsteen",
							album_name: "Darkness on the Edge of Town",
							played_at: now - 300
						})
			some_other_channel.tracks.create({
							track_name: "Some Other Song",
							artist_name: "Not Bruce",
							album_name: "Some Album",
							played_at: now
						})
			
			bruce_channel.most_recent_track.should == atlantic_city

		end
	end

end
