

def create_bookmarks
  visit '/links'
  click_button 'Add link'
  fill_in 'title', with: "Lou's blog"
  fill_in 'url', with: 'http://makersblog.herokuapp.com'
  fill_in 'tag', with: 'social'
  click_button 'Submit'

  click_button 'Add link'
  fill_in 'title', with: "Bubbly"
  fill_in 'url', with: 'http://bub-bub.com'
  fill_in 'tag', with: 'bubbles'
  click_button 'Submit'

  click_button 'Add link'
  fill_in 'title', with: "Facebook"
  fill_in 'url', with: 'http://facebook.com'
  fill_in 'tag', with: 'procrastination, bubbles'
  click_button 'Submit'
end

def create_user
  visit '/users/new'
  fill_in 'username', with: 'Bob'
  fill_in 'email', with: 'bob@bobmail.com'
  fill_in 'password', with: 'secret'
  fill_in 'password_confirmation', with: 'secret'
  click_button 'Sign up'
end
