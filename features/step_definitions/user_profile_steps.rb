Given("I am logged in") do
  @user = User.create!(email: "user1@utrgv.edu", password: "password123", role: "user")
  login_as(@user, scope: :user)
end

When("I go to my profile") do
  visit user_path(@user)
end

When("I go to the edit profile page") do
  visit edit_user_path(User.first)
end

And("I update my contact info") do
  fill_in "Email", with: "updated_user@utrgv.edu"
  fill_in "Name", with: "Updated Name"
  click_button "Update"
end
Then("I should see a success message") do
  expect(page).to have_content("Profile updated successfully!")
end

When("I click the logout button") do
  find("#logout-link", visible: :all).click
end

Then("I should be signed out and redirected to the login page") do
  expect(page).to have_current_path(email_login_path)
  expect(page).to have_content("Login")
end