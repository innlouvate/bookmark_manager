require_relative 'web_helper'

feature 'can filter links based on tags' do

  scenario 'filtered page only contains tags of the correct type' do
    create_user
    create_bookmarks
    fill_in 'search', with: 'bubbles'
    click_button 'Search links'
    # visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).to have_content('URL: http://bub-bub.com')
      expect(page).not_to have_content('http://makersblog.herokuapp.com')
    end

  end

    scenario 'can input multiple tags and filter on one of the tags' do
      create_user
      create_bookmarks
      visit '/links'
      fill_in 'search', with: 'bubbles'
      click_button 'Search links'
      # visit '/tags/bubbles'
      within 'ul#links' do
        expect(page).to have_content('URL: http://bub-bub.com')
        expect(page).not_to have_content('http://makersblog.herokuapp.com')
        expect(page).to have_content('http://facebook.com')
      end

    end
end
