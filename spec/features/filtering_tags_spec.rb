
feature 'can filter links based on tags' do

  scenario 'filtered page only contains tags of the correct type' do
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

    fill_in 'search', with: 'bubbles'
    click_button 'Search links'
    # visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).to have_content('URL: http://bub-bub.com')
      expect(page).not_to have_content('http://makersblog.herokuapp.com')
    end

  end
end
