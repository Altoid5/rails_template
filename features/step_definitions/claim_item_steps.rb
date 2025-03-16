Given("I am logged in as a UTRGV user") do
  @user = User.create(email: "student@utrgv.edu", password: "password123", confirmed_at: Time.now)
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

And("I submit the claim without proof") do
  click_button "Submit Claim"
end

Then("I should see an error message") do
  expect(page).to have_content("Error: Proof of ownership is required.")
end

Given("I submitted a claim for a found item") do
  @claim = Claim.create(user: @user, found_item: @found_item, proof_provided: false, status: "pending")
end

When("my proof of ownership is not sufficient") do
  @claim.update(status: "rejected")
end

Then("my claim should be rejected") do
  expect(@claim.reload.status).to eq("rejected")
end

And("I should receive a rejection notification") do
  Notification.create(user: @user, message: "Your claim has been rejected due to insufficient proof.")
  expect(Notification.last.message).to include("Your claim has been rejected")
end
