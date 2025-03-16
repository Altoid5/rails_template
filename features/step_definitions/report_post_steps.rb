Given("I am on a lost item page") do
  @lost_item = LostItem.create(name: "Backpack", location: "Library", description: "Black Nike backpack", reported_by: "user@utrgv.edu")
  visit lost_item_path(@lost_item)
end

When("I click the report button") do
  click_button "Report Post"
end

And("I select {string}") do |reason|
  select reason, from: "Report Reason"
  click_button "Submit Report"
end

Then("the post should be flagged for admin review") do
  expect(page).to have_content("This post has been reported for review.")
end

Given("I am on a found item page") do
  @found_item = FoundItem.create(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet", found_by: "user@utrgv.edu")
  visit found_item_path(@found_item)
end
