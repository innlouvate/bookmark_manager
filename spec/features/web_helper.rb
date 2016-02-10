

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
end
