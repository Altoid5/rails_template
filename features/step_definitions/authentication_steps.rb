Given("I am on the login page") do
  visit new_user_session_path
end

When("I enter my UTRGV email") do
  fill_in "Email", with: "student@utrgv.edu"
  fill_in "Password", with: "password123"
end

And("I pass the random letter verification") do
  # Simulating the random letter verification input
  fill_in "Verification Letter", with: "A"
end

Then("I should be logged in successfully") do
  click_button "Log in"
  expect(page).to have_content("Welcome, student@utrgv.edu")
end

When("I enter a non-UTRGV email") do
  fill_in "Email", with: "randomuser@gmail.com"
  fill_in "Password", with: "password123"
end

Then("I should see an error message") do
  click_button "Log in"
  expect(page).to have_content("Invalid email or password")
end

When("I select guest login") do
  click_button "Continue as Guest"
end

Then("I should have limited access to the website") do
  expect(page).to have_content("You are browsing as a guest")
end
