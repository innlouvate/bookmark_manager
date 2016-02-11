require_relative 'web_helper'

feature 'Creating links' do
  scenario 'I can save links' do
    create_user
    create_bookmarks
    visit '/links'
    within 'ul#links' do
      expect(page).to have_content("Lou's blog")
    end
  end


  scenario 'I can add tags to a given link whilst saving it' do
    create_user
    create_bookmarks
    visit '/links'
    within 'ul#links' do
      expect(page).to have_content("Tags: social")
    end
  end

end
