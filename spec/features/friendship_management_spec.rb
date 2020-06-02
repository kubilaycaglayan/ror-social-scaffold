require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before :each do
    User.create(name: 'Marios', email: 'b@b.com', password: '000000', password_confirmation: '000000')
    User.create(name: 'Kubilay', email: 'a@b.com', password: '000000', password_confirmation: '000000')
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'b@b.com'
      fill_in 'user_password', with: '000000'
    end
    click_button 'commit'
    visit '/users'
  end

  it 'allows user to send invitations to other users' do
    expect(page).to have_content('Invite to Friendship')
  end

  it 'allows users to accept invitations' do
    Friendship.create(user_id: 2, friend_id: 1)
    click_link('My Page')
    expect(page).to have_content('Accept Invitation')
  end

  it 'allows users to accept invitations' do
    Friendship.create(user_id: 2, friend_id: 1)
    click_link('My Page')
    expect(page).to have_content('Reject Invitation')
  end
end
