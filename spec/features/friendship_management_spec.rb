describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end
  it 'signs me in' do
    print 'management file'
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'commit'
    expect(page).to have_content 'success'
  end

  it 'signs me out' do
    visit 'users'
    within('#sessions') do
      click_button 'nofollow'
      expect(page).to have_content 'Sign in'
    end
  end
end
