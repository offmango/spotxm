Given /^there are "(.*?)" tracks in the database for channel "(.*?)"$/ do |number_of_tracks, channel_number|
  	channel = Channel.create(channel_number: channel_number.to_i)
  	(1..number_of_tracks.to_i).each { |i| channel.tracks.build(track_name: "track_#{i}", artist_name: "artist_#{i}", album_name: "album_#{i}") }
  	channel.save
end

When /^I view the page for channel "(.*?)"$/ do |channel_number|
	channel = Channel.find_by_channel_number(channel_number.to_i)
	visit channel_path(channel)
end

Then /^I should see pagination links$/ do
  	page.should have_css('.pagination')
end

Then /^I should not see pagination links$/ do
	page.should_not have_css('.pagination')
end