Given("I am on the lost and found page") do
  visit lost_and_found_path
end

When("I enter an item name in the search bar") do
  fill_in "Search", with: "Laptop"
end

And("I click search") do
  click_button "Search"
end

Then("I should see relevant results") do
  expect(page).to have_content("Laptop")
end

When("I select a category from the filter options") do
  select "Electronics", from: "Category"
end

When("I select a date range from the filter options") do
  fill_in "Start Date", with: "2024-03-01"
  fill_in "End Date", with: "2024-03-10"
end

And("I click apply filters") do
  click_button "Apply Filters"
end

Then("I should see only items in that category") do
  expect(page).to have_content("Electronics")
end

Then("I should see only items reported within that range") do
  within(".results") do
    expect(page).to have_content("Laptop")
    expect(page).not_to have_content("Older Item")
  end
end
