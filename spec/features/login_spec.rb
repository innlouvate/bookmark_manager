
feature 'successful login' do
  scenario 'when a user signs up, the User count increases by 1' do
    visit '/users/new'
    fill_in 'username', with: 'Bob'
    fill_in 'email', with: 'bob@bobmail.com'
    fill_in 'password', with: 'secret'
    expect{click_button 'Sign up'}.to change{ User.count }.by(1)
  end

  scenario 'welcome message displayed on successful login/sign-up' do
    visit '/users/new'
    create_user
    expect(page).to have_content('Welcome Bob')
  end

  scenario 'user email is logged and correct on sign-up' do
    create_user
    expect(User.first(email: 'bob@bobmail.com')).to_not be_nil
  end

end