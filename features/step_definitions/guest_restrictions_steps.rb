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
