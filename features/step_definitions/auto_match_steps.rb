Given("a new found item is reported") do
  @found_item = FoundItem.create(name: "Backpack", location: "Library", description: "Black Nike backpack")
end

And("its details match a lost item") do
  @lost_item = LostItem.create(name: "Backpack", location: "Library", description: "Black Nike backpack", reported_by: "student@utrgv.edu")
end

When("the system runs an auto-match check") do
  if @found_item.name == @lost_item.name && @found_item.location == @lost_item.location
    Notification.create(user_email: @lost_item.reported_by, message: "A matching item has been found!")
  end
end

Then("the user who lost the item should receive a notification") do
  expect(Notification.last.message).to include("A matching item has been found!")
end

Given("a user tries to submit a lost item report") do
  @new_lost_item = LostItem.new(name: "Laptop", location: "Library", description: "Silver MacBook")
end

And("a similar report already exists") do
  @existing_lost_item = LostItem.create(name: "Laptop", location: "Library", description: "Silver MacBook")
end

When("they submit the form") do
  @new_lost_item.save
end

Then("they should receive a warning about the duplicate") do
  if LostItem.exists?(name: @new_lost_item.name, location: @new_lost_item.location)
    expect(page).to have_content("Warning: A similar lost item has already been reported.")
  end
end
