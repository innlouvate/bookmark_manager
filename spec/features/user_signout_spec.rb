feature 'user can sign out' do
  scenario 'user clicks sign out button' do
    sign_up
    sign_out
    expect(page).to have_content "Come back soon"
    expect(page).not_to have_content "Welcome, test@testmail.com!"
    expect(current_path).to eq('/link')
  end
end
