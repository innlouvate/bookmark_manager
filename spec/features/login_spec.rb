feature 'successful login' do
  scenario 'when a user signs up, the User count increases by 1' do
    visit '/users/new'
    fill_in 'username', with: 'Bob'
    fill_in 'email', with: 'bob@bobmail.com'
    fill_in 'password', with: 'secret'
    fill_in 'password_confirmation', with: 'secret'
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

  scenario 'mismatching passwords causes error message' do
    incorrect_sign_up
    click_button 'Sign up'
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'stay on the same page when mismatching passwords entered' do
    incorrect_sign_up
    click_button 'Sign up'
    expect(current_path).to eq('/users')
  end

  scenario 'user count does not increase when passwords do not match' do
    incorrect_sign_up
    expect{click_button 'Sign up'}.to change{User.count}.by(0)
  end

  scenario 'user count does not increase if blank email entered' do
    visit '/users/new'
    fill_in 'username', with: 'Bob'
    fill_in 'email', with: ''
    fill_in 'password', with: 'aa'
    fill_in 'password_confirmation', with: 'aa'
    expect{click_button 'Sign up'}.to change{User.count}.by(0)
  end

  scenario 'user count does not increase if email is in email format' do
    visit '/users/new'
    fill_in 'username', with: 'Bob'
    fill_in 'email', with: 'something'
    fill_in 'password', with: 'aa'
    fill_in 'password_confirmation', with: 'aa'
    expect{click_button 'Sign up'}.to change{User.count}.by(0)
  end

  scenario 'user count does not increase if blank password entered' do
    visit '/users/new'
    fill_in 'username', with: 'Bob'
    fill_in 'email', with: 'somthing@gmail.com'
    fill_in 'password', with: ''
    fill_in 'password_confirmation', with: ''
    expect{click_button 'Sign up'}.to change{User.count}.by(0)
  end

  scenario 'user count does not increase if blank username entered' do
    visit '/users/new'
    fill_in 'username', with: ''
    fill_in 'email', with: 'somthing@gmail.com'
    fill_in 'password', with: 'aa'
    fill_in 'password_confirmation', with: 'aa'
    expect{click_button 'Sign up'}.to change{User.count}.by(0)
  end

end
