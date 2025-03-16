Given("a user has submitted multiple false reports") do
  @user = User.create(email: "abusive_user@utrgv.edu", flagged: false, report_count: 3)
end

When("they reach the report limit") do
  @user.update(report_count: 5)
  if @user.report_count >= 5
    @user.update(flagged: true)
  end
end

Then("their account should be flagged") do
  expect(@user.flagged).to be true
end

Then("they should receive a warning notification") do
  expect(Notification.last.message).to include("Your account has been flagged for excessive reporting.")
end

Given("I am logged in as an admin") do
  @admin = User.create(email: "admin@utrgv.edu", role: "admin")
end

And("there are flagged users in the system") do
  @flagged_users = User.where(flagged: true)
end

When("I navigate to the flagged users list") do
  visit admin_flagged_users_path
end

Then("I should see all flagged users") do
  @flagged_users.each do |user|
    expect(page).to have_content(user.email)
  end
end

When("I click {string}") do |button_text|
  click_button button_text
end

Then("their account should be disabled") do
  expect(@user.disabled?).to be true
end

Given("I am logged in as a flagged user") do
  @user = User.create(email: "flagged_user@utrgv.edu", flagged: true)
end

When("I visit my profile page") do
  visit user_profile_path(@user)
end

Then("I should see a warning message about my flagged status") do
  expect(page).to have_content("Your account has been flagged due to excessive reports.")
end
