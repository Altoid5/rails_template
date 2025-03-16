Given("I am logged in as a guest") do
  visit new_guest_session_path
  click_button "Continue as Guest"
end

When("I go to the report lost item page") do
  visit new_lost_item_path
end

And("I fill out the details") do
  fill_in "Item Name", with: "Black Jacket"
  fill_in "Description", with: "Lost near the library"
  fill_in "Location", with: "Library"
end

Then("my report should be submitted") do
  click_button "Report Lost Item"
  expect(page).to have_content("Your lost item has been reported")
end

When("I try to access the report found item page") do
  visit new_found_item_path
end

Then("I should see an error message") do
  expect(page).to have_content("Guest users cannot report found items.")
end

When("I try to edit or delete a post") do
  visit edit_lost_item_path(1) # Assuming ID 1 for testing
end

Then("I should see an error message") do
  expect(page).to have_content("Guest users cannot edit or delete posts.")
end

When("I try to claim a found item") do
  visit claim_found_item_path(1) # Assuming ID 1 for testing
end

Then("I should see an error message") do
  expect(page).to have_content("Guest users cannot claim items.")
end
