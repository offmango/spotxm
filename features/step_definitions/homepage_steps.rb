When /^I view the homepage$/ do
  	visit root_path
end

Then /^I should be able to see details about the application$/ do
  	page.should have_css('h1', text:"SpotXM")
  	page.should have_css('title', text:"SpotXM")
  	page.should have_css('#about-service')
end

Then /^I should see the following tracks on the current playlist:$/ do |tracks_table|  	
  	within "table#now_playing" do
		tracks_table.hashes.each do |track_hash|
			within "tr##{track_hash[:channel_number]}" do
				page.should have_css('td', text: "#{track_hash[:channel_number]}")
				page.should have_css('td', text: "#{track_hash[:channel_name]}")				
				page.should have_css('td', text: "#{track_hash[:track_name]}")
				page.should have_css('td', text: "#{track_hash[:artist_name]}")
				page.should have_css('td', text: "#{track_hash[:album_name]}")
			end
		end
	end
end
