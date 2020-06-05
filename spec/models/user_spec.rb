require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      name: 'Marios',
      email: 't@t.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end
  let(:user2) do
    User.new(
      name: 'Kubilay',
      email: 'y@y.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end

  describe 'validations' do
    it 'must have a name shorter than 20 chars' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many invitations' do
      expect(user).to respond_to(:invitations)
    end

    it 'has many pending invitations' do
      expect(user).to respond_to(:pending_invitations)
    end

    it 'has many posts' do
      expect(user).to respond_to(:posts)
    end

    it 'has many comments' do
      expect(user).to respond_to(:comments)
    end

    it 'has many likes' do
      expect(user).to respond_to(:likes)
    end
  end

  describe 'unit tests' do
    it 'can send invitation' do
      User.first.send_invitation(User.last)
      record = Friendship.all
      expect(record.empty?).to be false
    end

    it 'rejects pending invitation' do
      User.first.send_invitation(User.last)
      User.last.destroy_pending_invitation(User.first)
      record = Friendship.all
      expect(record.empty?).to be true
    end

    it 'accepts pending invitation' do
      User.first.send_invitation(User.last)
      User.last.accept_pending_invitation(User.first)
      record = Friendship.first
      expect(record.status).to be true
    end

    it 'checks invitation' do
      User.first.send_invitation(User.last)
      record = User.first.check_invitation(1, 2)
      expect(record).to be true
    end

    it 'checks friendship' do
      Friendship.create(user_id: 1, friend_id: 2, status: true)
      record = User.first.friend_with?(User.last)
      expect(record).to be true
    end

    it 'returns an array of friend ids' do
      Friendship.create(user_id: 1, friend_id: 2, status: true)
      record = User.first.friends
      expect(record).to match_array([2])
    end
  end
end
