# Viewing Lost and Found List
Given("I am viewing the lost and found page") do
  visit lost_and_found_path
end

And("another user reports a lost item") do
  @new_item = LostItem.create(name: "Laptop", location: "Library", description: "Silver MacBook", reported_by: "user1@utrgv.edu")
  ActionCable.server.broadcast("lost_found_channel", @new_item)
end

Then("I should see the new lost item appear without refreshing") do
  expect(page).to have_content("Laptop")
end

# Claimed item disappears
Given("I am viewing the found items list") do
  visit found_items_path
end

And("another user successfully claims an item") do
  @found_item = FoundItem.create(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet")
  @found_item.update(claimed: true)
  ActionCable.server.broadcast("lost_found_channel", @found_item)
end

Then("the claimed item should disappear from my screen without refreshing") do
  expect(page).not_to have_content("Wallet")
end

# Notification match
Given("I have reported a lost item") do
  @my_lost_item = LostItem.create(name: "Backpack", location: "Gym", description: "Black Nike backpack", reported_by: "me@utrgv.edu")
end

And("another user finds an item that matches my report") do
  @matching_item = FoundItem.create(name: "Backpack", location: "Gym", description: "Black Nike backpack", found_by: "someone@utrgv.edu")
end

When("the system detects a match") do
  if @my_lost_item.name == @matching_item.name && @my_lost_item.location == @matching_item.location
    Notification.create(user_email: @my_lost_item.reported_by, message: "A matching item has been found!")
  end
end

Then("I should receive a real-time notification") do
  expect(Notification.last.message).to include("A matching item has been found!")
end

# Viewer indicator
Given("I am viewing a lost item page") do
  visit lost_item_path(@my_lost_item)
end

When("another user is also viewing the same page") do
  @viewer_count = 2
  ActionCable.server.broadcast("viewers_channel", count: @viewer_count)
end

Then("I should see a {string} indicator") do |indicator_text|
  expect(page).to have_content(indicator_text)
end
