Given('a user is flagged for excessive reports') do
  @user = User.create!(
    email: 'flagged_user@utrgv.edu',
    password: 'secure123',
    report_count: 5,
    flagged: true,
    confirmed_at: Time.now # Only include this if your User model has `confirmed_at`
  )


  Notification.create!(
    user: @user,
    message: "Your account has been flagged for excessive reporting."
  )
end

Given("a user has submitted many reports") do
  @user = User.create!(email: "frequent@utrgv.edu", password: "password123", report_count: 5)
end

When("the report count exceeds the limit") do
  if @user.report_count >= 5
    @user.update(flagged: true)
    Notification.create!(user: @user, message: "Your account has been flagged for excessive reporting.")
  end
end

Then("their account should be flagged") do
  expect(@user.flagged).to be true
end

Then("they should receive a warning notification") do
  expect(Notification.last.message).to include("Your account has been flagged for excessive reporting.")
end

Given("I am logged in as an admin") do
  @admin = User.create(email: "admin@utrgv.edu", role: "admin", password: "secure123")
  login_as(@admin, scope: :user)
end

And("flagged users exist") do
  @flagged_users = [
    User.create(email: "flag1@utrgv.edu", flagged: true),
    User.create(email: "flag2@utrgv.edu", flagged: true)
  ]
end

When("I go to the flagged users list") do
  visit admin_flagged_users_path
end

Then("I should see a list of all flagged users") do
  @flagged_users.each do |user|
    expect(page).to have_content(user.email)
  end
end

When("I choose to ban the user") do
  @user.update(disabled: true)
end

Then("the user’s account should be disabled") do
  expect(@user.disabled).to be true
end

Given("I am logged in as a flagged user") do
  @user = User.create(email: "flagged_user@utrgv.edu", flagged: true, password: "secure123")
  login_as(@user, scope: :user)
end



Then("I should see a flagged warning message") do
  expect(page).to have_content("Your account has been flagged due to excessive reports.")
end