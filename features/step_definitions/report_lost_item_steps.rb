Given("I am logged in as a UTRGV user") do
  @user = User.create(email: "student@utrgv.edu", password: "password123", confirmed_at: Time.now)
  login_as(@user, scope: :user)
end

And("I am on the report lost item page") do
  visit new_lost_item_path
end

When("I fill in all required lost item details") do
  fill_in "Item Name", with: "Laptop"
  fill_in "Description", with: "Silver MacBook with stickers"
  fill_in "Location", with: "Library"
  select "Electronics", from: "Category"
end

When("I leave required fields blank") do
  fill_in "Item Name", with: ""
  fill_in "Description", with: ""
  fill_in "Location", with: ""
end

When("I submit the form") do
  click_button "Report Lost Item"
end

Then("I should see a confirmation message") do
  expect(page).to have_content("Your lost item has been reported")
end

Then("I should see an error message") do
  expect(page).to have_content("Error: Please fill in all required fields")
end

When("I upload an image of the lost item") do
  attach_file("Image", Rails.root.join("spec/fixtures/sample_image.jpg"))
end

Then("I should see the image preview in my post") do
  expect(page).to have_selector("img[src*='sample_image.jpg']")
end

When("I upload a non-image file") do
  attach_file("Image", Rails.root.join("spec/fixtures/sample_document.pdf"))
end

Then("I should see an error message") do
  expect(page).to have_content("Error: Invalid file format. Please upload an image.")
end
