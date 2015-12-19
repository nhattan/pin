feature "Signing in" do
  background do
    @user = create(:user)
  end

  scenario "Signing in with correct credentials" do
    visit '/login'
    within("#new_user") do
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => @user.password
    end
    click_button 'Log in'
    expect(page).to have_content "Signed in successfully. Waiting for something cool with Tan!"
  end

  given(:other_user) { create(:user) }

  scenario "Signing in as another user" do
    visit '/login'
    within("#new_user") do
      fill_in 'Email', :with => other_user.email
      fill_in 'Password', :with => 'wrong-password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid email or password'
  end
end
