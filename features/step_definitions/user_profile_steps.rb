Given("I am logged in") do
  @user = User.create!(email: "student@utrgv.edu", password: "password123")
  login_as(@user, scope: :user)
end

When("I navigate to my profile page") do
  visit user_path(@user) # or user_profile_path(@user) if you have a custom route
end

And("I update my contact details") do
  fill_in "Phone Number", with: "555-1234"
  click_button "Save Changes"
end

Then("my changes should be saved") do
  expect(page).to have_content("Profile updated successfully")
  expect(@user.reload.phone_number).to eq("555-1234")
end

When("I go to my profile") do
  visit user_path(@user)
end

Then("I should see a list of my previous lost and found reports") do
  LostItem.create!(name: "Backpack", location: "Gym", description: "Black Nike backpack", reported_by: @user.email)
  FoundItem.create!(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet", found_by: @user.email)

  visit user_path(@user)
  expect(page).to have_content("Backpack")
  expect(page).to have_content("Wallet")
end

When("I choose to deactivate my account") do
  click_button "Deactivate Account"
end

And("I confirm the action") do
  click_button "Confirm Deactivation"
end

Then("my account should be deactivated") do
  expect(@user.reload.deactivated).to be true
  expect(page).to have_content("Your account has been deactivated")
end
