Given /^the following tracks are playing on sirius xm:$/ do |tracks_table|
	Track.stubs(:now_playing).returns(tracks_table.hashes)
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