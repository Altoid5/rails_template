Given("I am logged in to claim a found item") do
  @user ||= User.create!(email: "student@utrgv.edu", password: "password123")
  login_as(@user, scope: :user)
end

And("I am on a found item page") do
  @found_item = FoundItem.create(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet")
  visit found_item_path(@found_item)
end

When("I click the claim button") do
  click_button "Claim Item"
end

And("I provide proof of ownership") do
  attach_file("Proof of Ownership", Rails.root.join("spec/fixtures/sample_receipt.pdf"))
end

Then("my claim should be submitted for approval") do
  click_button "Submit Claim"
  expect(page).to have_content("Your claim has been submitted for approval.")
end