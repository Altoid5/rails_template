Given("I have reported a lost item") do
  @user = User.create(email: "student@utrgv.edu", password: "password123", confirmed_at: Time.now)
  login_as(@user, scope: :user)
  @lost_item = LostItem.create(name: "Backpack", location: "Library", description: "Black Nike backpack", reported_by: @user.email)
end

When("a similar item is found") do
  @found_item = FoundItem.create(name: "Backpack", location: "Library", description: "Black Nike backpack")
  if @found_item.name == @lost_item.name && @found_item.location == @lost_item.location
    Notification.create(user_email: @lost_item.reported_by, message: "A matching item has been found!")
  end
end

Then("I should receive a notification") do
  expect(Notification.last.message).to include("A matching item has been found!")
end

Given("I have submitted a claim for a found item") do
  @user = User.create(email: "student@utrgv.edu", password: "password123", confirmed_at: Time.now)
  login_as(@user, scope: :user)
  @found_item = FoundItem.create(name: "Wallet", location: "Cafeteria", description: "Brown leather wallet")
  @claim = Claim.create(user: @user, found_item: @found_item, proof_provided: true, status: "pending")
end

When("my claim is approved") do
  @claim.update(status: "approved")
  Notification.create(user: @claim.user, message: "Your claim for #{@found_item.name} has been approved!")
end

Then("I should receive a notification") do
  expect(Notification.last.message).to include("Your claim for #{@found_item.name} has been approved!")
end
