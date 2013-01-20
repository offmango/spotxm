Given /^the (\w+) indexes are processed$/ do |model|
	model = model.titleize.gsub(/\s/, '').constantize
	puts "Processing #{model} index"
	ThinkingSphinx::Test.index *model.sphinx_index_names
	sleep(1.00) # Wait for Sphinx to catch up
end

Given /^the following tracks are in the database:$/ do |tracks_table|
	#Track.all.each { |track| track.delete }
  	#Channel.all.each { |channel| channel.delete }
	tracks_table.hashes.each do |track_hash| 
		channel = Channel.find_or_create_by_channel_number(track_hash[:channel_number])
		channel.tracks.create(track_hash)
	end
end

When /^I search for the channel number "(.*?)"$/ do |channel_number|
	fill_in 'channel-search', with: channel_number
	click_button 'Find Channel'
end

When /^I search tracks for "(.*?)"$/ do |search_term|
	fill_in 'track-search', with: search_term
	click_button 'Find Track'
end

Then /^I should see a list of the following tracks:$/ do |tracks_table|
	within "table#track_listing" do
		tracks_table.hashes.each do |track_hash|			
			page.should have_css('td', text: "#{track_hash[:track_name]}")
			page.should have_css('td', text: "#{track_hash[:artist_name]}")
			page.should have_css('td', text: "#{track_hash[:album_name]}")
		end
	end
end

Then /^I should see the now playing information for "(.*?)" for the following tracks:$/ do |channel_number, tracks_table|
  	within "div#now_playing" do
		page.should have_css('#channel_number', text: channel_number)
		tracks_table.hashes.each do |song_hash|
			page.should have_css('span.song_info', text: "#{song_hash[:song_name]} by #{song_hash[:artist_name]}")
		end
	end
end

Then /^I should see a playlist for channel "(.*?)" with the following tracks:$/ do |channel_number, tracks_table|
	page.should have_css('#channel_description', text: "Now Playing on Channel #{channel_number}")
	within "table#track_listing" do
		tracks_table.hashes.each do |track_hash|			
			page.should have_css('td', text: "#{track_hash[:track_name]}")
			page.should have_css('td', text: "#{track_hash[:artist_name]}")
			page.should have_css('td', text: "#{track_hash[:album_name]}")
		end
	end

end
