Given("I am logged in") do
  @user = User.create(email: "student@utrgv.edu", password: "password123", confirmed_at: Time.now)
  login_as(@user, scope: :user)
end

When("I navigate to my profile page") do
  visit user_profile_path(@user)
end

And("I update my contact details") do
  fill_in "Phone Number", with: "555-1234"
  click_button "Save Changes"
end

Then("my changes should be saved") do
  expect(page).to have_content("Profile updated successfully")
end

When("I go to my profile") do
  visit user_profile_path(@user)
end

Then("I should see a list of my previous lost and found reports") do
  @lost_item = LostItem.create(name: "Backpack", location: "Gym", description: "Black Nike backpack", reported_by: @user.email)
  @found_item = FoundItem.create(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet", found_by: @user.email)

  expect(page).to have_content(@lost_item.name)
  expect(page).to have_content(@found_item.name)
end

When("I choose to deactivate my account") do
  click_button "Deactivate Account"
end

And("I confirm the action") do
  click_button "Confirm Deactivation"
end

Then("my account should be deactivated") do
  @user.update(deactivated: true)
  expect(@user.reload.deactivated).to be true
  expect(page).to have_content("Your account has been deactivated")
end
