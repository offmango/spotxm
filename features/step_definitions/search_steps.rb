When /^I search for the channel name "(.*?)"$/ do |channel_name|
	visit root_path
	fill_in 'Find Channel', with: channel_name
	click_button 'Find'
end

Then /^I should see the now playing info for the channel "(.*?)"$/ do |channel_name|
  	page.should have_css('#now_playing')
  	page.should have_no_css('form')
end
