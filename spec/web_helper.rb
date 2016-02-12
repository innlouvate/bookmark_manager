def sign_up(email: 'test@testmail.com', password: 'password', password_confirmation: 'password')
  visit('/sign-up')
  fill_in 'email', with: email
  fill_in 'password', with: password
  fill_in 'password_confirmation', with: password_confirmation
  click_button 'Create account'
end

def sign_out
  visit '/link'
  click_button 'sign out'
end
