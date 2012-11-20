Given /^the following tracks are in the database:$/ do |tracks_table|
	Track.all.each { |track| track.delete }
  	Channel.all.each { |channel| channel.delete }
	tracks_table.hashes.each do |track_hash| 
		channel = Channel.find_or_create_by_channel_number(track_hash[:channel_number])
		channel.tracks.create(track_hash)
	end
end

Then /^I should see a playlist for channel "(.*?)" with the following songs:$/ do |channel_number, tracks_table|
  pending # express the regexp above with the code you wish you had
end

When /^I search for the channel number "(.*?)"$/ do |channel_number|
	visit root_path
	fill_in 'Find Channel', with: channel_number
	click_button 'Find'
end

Then /^I should see the now playing information for "(.*?)" for the following tracks:$/ do |channel_number, tracks_table|
  	within "div#now_playing" do
		page.should have_css('#channel_number', text: channel_number)
		tracks_table.hashes.each do |song_hash|
			page.should have_css('span.song_info', text: "#{song_hash[:song_name]} by #{song_hash[:artist_name]}")
		end
	end
end