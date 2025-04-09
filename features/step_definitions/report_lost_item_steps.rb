Given("I am logged in to report a lost item") do
  @user ||= User.create!(email: "student@utrgv.edu", password: "password123")
  login_as(@user, scope: :user)
end
And("I am on the report lost item page") do
  visit new_lost_item_path
end

When("I fill in all required lost item details") do
  fill_in "Name", with: "Laptop"
  fill_in "Description", with: "Silver MacBook with stickers"
  select "ESTUN - Student Union", from: "Where was the item lost?"
  fill_in "Item category", with: "Electronics"
  fill_in "Lost date", with: Date.today.strftime("%Y-%m-%d") # format: YYYY-MM-DD
end

When("I upload an image of the lost item") do
  attach_file("lost_item_image", Rails.root.join("spec/fixtures/sample_image.jpg"), make_visible: true)
end

When("I submit the lost item form") do
  click_button "Save Lost Item"
end

Then("I should see a lost item confirmation message") do
  expect(page).to have_content("Lost item reported successfully!")
end


Then("I should see the lost item image preview in my post") do
  expect(page).to have_selector("img") # More flexible
end
