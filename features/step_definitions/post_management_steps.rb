Given("I am logged in to manage my posts") do
  @user ||= User.create!(email: "student@utrgv.edu", password: "password123")
  login_as(@user, scope: :user)
end

And("I am viewing my lost item post") do
  @lost_item = LostItem.create(name: "Laptop", location: "Library", description: "Silver MacBook", user: @user)
  visit lost_item_path(@lost_item)
end

When("I click the edit button") do
  click_link_or_button "Edit"
end

And("I update the details") do
  fill_in "Item Name", with: "Updated Laptop Name"
  click_button "Save Changes"
end

Then("my changes should be saved") do
  expect(page).to have_content("Updated Laptop Name")
end

And("I am viewing my found item post") do
  @found_item = FoundItem.create(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet", user: @user)
  visit found_item_path(@found_item)
end

When("I click the delete button") do
  click_button "Delete"
end

Then("my post should be removed from the system") do
  expect(page).not_to have_content("Wallet")
end