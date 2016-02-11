require_relative 'web_helper'

feature 'Creating links' do
  scenario 'I can save links' do
    create_user
    visit '/links'
    click_button 'Add link'
    fill_in 'title', with: "Lou's blog"
    fill_in 'url', with: 'http://makersblog.herokuapp.com'
    click_button 'Submit'
    within 'ul#links' do
      expect(page).to have_content("Lou's blog")
    end
  end


  scenario 'I can add tags to a given link whilst saving it' do
    create_user
    visit '/links'
    click_button 'Add link'
    fill_in 'title', with: "Lou's blog"
    fill_in 'url', with: 'http://makersblog.herokuapp.com'
    fill_in 'tag', with: 'social'
    click_button 'Submit'
    within 'ul#links' do
      expect(page).to have_content("Tags: social")
    end
  end

end
