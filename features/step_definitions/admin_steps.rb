Given("I am logged in as an admin") do
  @admin = User.create(email: "admin@utrgv.edu", password: "adminpass", role: "admin", confirmed_at: Time.now)
  login_as(@admin, scope: :user)
end

When("I navigate to the admin dashboard") do
  visit admin_dashboard_path
end

Then("I should see a list of reported posts") do
  @reported_posts = LostItem.where(reported: true) + FoundItem.where(reported: true)
  @reported_posts.each do |post|
    expect(page).to have_content(post.name)
  end
end

And("a user has multiple false reports") do
  @user = User.create(email: "user@utrgv.edu", report_count: 3)
end

When("I click the {string} button") do |button_text|
  click_button button_text
end

Then("the user should no longer be able to log in") do
  expect(User.find_by(email: @user.email).disabled?).to be true
end

When("I navigate to the deleted posts section") do
  visit admin_deleted_posts_path
end

And("I select a post to restore") do
  @deleted_post = LostItem.create(name: "Watch", deleted: true)
  visit admin_deleted_posts_path
  click_button "Restore", match: :first
end

Then("the post should be visible again") do
  expect(@deleted_post.reload.deleted?).to be false
end

And("a claim for a high-value item is pending") do
  @pending_claim = Claim.create(user: @user, found_item: @found_item, status: "pending")
end

When("I verify the claim details") do
  visit admin_claims_path
  expect(page).to have_content(@pending_claim.user.email)
end

And("I approve the claim") do
  click_button "Approve"
end

Then("the claimant should receive a confirmation") do
  expect(Notification.last.message).to include("Your claim has been approved")
end
