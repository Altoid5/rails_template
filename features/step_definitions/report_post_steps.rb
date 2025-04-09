Given("I am on a lost item page") do
  @lost_item = LostItem.create(name: "Backpack", location: "Library", description: "Blue backpack", reported_by: "student@utrgv.edu")
  visit lost_item_path(@lost_item)
end

Given("I am on a found item page") do
  @found_item = FoundItem.create(name: "Watch", location: "Gym", description: "Silver wristwatch", found_by: "staff@utrgv.edu")
  visit found_item_path(@found_item)
end

When("I click the report button") do
  click_button "Report"
end

And("I select {string}") do |reason|
  choose reason
  click_button "Submit Report"
end

Then("the post should be flagged for admin review") do
  expect(page).to have_content("Thank you for your report")
  expect(Report.last.reason).not_to be_nil
end