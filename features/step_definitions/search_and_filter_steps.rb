Given("I am on the lost and found page") do
  visit lost_items_path
end

When("I enter an item name in the search bar") do
  fill_in "Search", with: "Backpack"
end

When("I click search") do
  click_button "Search"
end

Then("I should see relevant results") do
  expect(page).to have_content("Backpack")
end

When("I select a category from the filter options") do
  select "Electronics", from: "Category"
end

When("I click apply filters") do
  click_button "Apply Filters"
end

Then("I should see only items in that category") do
  expect(page).to have_content("Electronics")
end

When("I select a date range from the filter options") do
  fill_in "From Date", with: 5.days.ago.to_date
  fill_in "To Date", with: Date.today
end

Then("I should see only items reported within that range") do
  expect(page).to have_content("Found within date range")
end