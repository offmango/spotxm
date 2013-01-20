Given /^the following channels are in the database:$/ do |channels_table|
	#Channel.all.each {|channel| channel.delete}
	channels_table.hashes.each { |channel_hash| Channel.create(channel_hash) } 
end

Given /^the following tracks are the most recently played on sirius xm:$/ do |tracks_table|
	#Track.all.each{ |track| track.delete }
	tracks_table.hashes.each do |track_hash| 
		channel = Channel.find_by_channel_number(track_hash[:channel_number])
		channel.tracks.create(track_hash)
	end
	Track.all.each {|track| puts "TRACK: #{track.track_name} ARTIST: #{track.artist_name}"}
end


When /^I view the homepage$/ do
  	visit root_path
end

When /^I click the link for channel "(.*?)"$/ do |channel_number|
	within "tr#channel_#{channel_number}" do
    	click_link "channel_link_#{channel_number}"
  	end
end


Then /^I should be able to see details about the application$/ do
  	page.should have_css('h1', text:"SpotXM")
  	page.should have_css('title', text:"SpotXM")
  	page.should have_css('#about-service')
end

Then /^I should see information on the following tracks:$/ do |tracks_table| 	
  	within "table#track_listing" do
		tracks_table.hashes.each do |track_hash|
			within "tr#channel_#{track_hash[:channel_number]}" do
				page.should have_css('td', text: "#{track_hash[:channel_number]}")
				page.should have_css('td', text: "#{track_hash[:channel_name]}")				
				page.should have_css('td', text: "#{track_hash[:track_name]}")
				page.should have_css('td', text: "#{track_hash[:artist_name]}")
				page.should have_css('td', text: "#{track_hash[:album_name]}")
			end
		end
	end
end
