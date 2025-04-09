require 'rspec/mocks'

Given('I visit the login page') do
  visit '/email_login'
end

When('I enter a valid UTRGV email') do
  fill_in 'UTRGV Email:', with: 'anthony.portales01@utrgv.edu'
  click_button 'Sign In'
end

When('I complete the random letter verification') do
  fill_in 'Verification Code', with: 'A'
  click_button 'Verify and Login'
end

Then('I should be logged in and redirected to the homepage') do
  expect(page).to have_content('Lost & Found')
end


When('I choose to log in as a guest') do
  click_link 'Login as Guest'
end

Then('I should see the guest homepage with limited access') do
  expect(page).to have_content('Lost & Found') # I need to set tis up later for limted acces
end