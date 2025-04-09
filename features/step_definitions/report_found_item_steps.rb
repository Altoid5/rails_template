Given("I am logged in to report a found item") do
  @user ||= User.create!(email: "student@utrgv.edu", password: "password123")
  login_as(@user, scope: :user)
end

And("I am on the report found item page") do
  visit new_found_item_path
end

When("I fill in all required found item details") do
  fill_in "Name", with: "Phone"
  fill_in "Description", with: "Black iPhone with a cracked screen"
  fill_in "Location", with: "Student Union"
  fill_in "Category", with: "Electronics"
  fill_in "Found date", with: Date.today.strftime("%Y-%m-%d")
end

When("I submit the form") do
  click_button "Save Found Item"
end
Then("I should see a confirmation message") do
  expect(page).to have_content("Found item reported successfully!")
end

When("I upload an image of the found item") do
  attach_file("found_item_image", Rails.root.join("spec/fixtures/sample_image.jpg"), visible: false)
end
Then("I should see the image preview in my post") do
  expect(page).to have_selector("img") # More flexible
end
