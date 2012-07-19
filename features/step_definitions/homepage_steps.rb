When /^I view the homepage$/ do
  visit root_path
end

Then /^I should be able to see details about the application$/ do
  page.should have_css('h1', text:"SpotXM")
  page.should have_css('title', text:"SpotXM")
  page.should have_css('#about-service')
end