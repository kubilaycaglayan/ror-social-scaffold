require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) do
    User.create(name: 'Marios', email: 'b@b.com',
                password: '000000', password_confirmation: '000000')
  end
  let(:user2) do
    User.create(name: 'Kubilay', email: 'a@b.com',
                password: '000000', password_confirmation: '000000')
  end

  let(:friendship) { Friendship.create(user_id: user1.id, friend_id: user2.id) }

  describe 'associations' do
    it 'belongs to a sender' do
      expect(friendship).to respond_to(:sender)
    end

    it 'belongs to a user' do
      expect(friendship).to respond_to(:user)
    end
  end

  describe 'validations' do
    it 'has uniqueness on columns sender_id and receiver_id' do
      friendship
      new_record = Friendship.new(user_id: user1.id, friend_id: user2.id)
      expect(new_record).not_to be_valid
    end
  end

  describe 'has two row approach' do
    it 'creates a mirror row when invitation is accepted' do
      Friendship.create(user_id: user2.id, friend_id: user1.id)
      user1.accept_pending_invitation(user2)
      record = Friendship.where(user_id: user1.id, friend_id: user2.id, status: true)
      expect(record.empty?).not_to be true
    end
  end

  describe 'unit tests' do
    it 'checks if the user send invitation' do
      Friendship.create(user_id: user1.id, friend_id: user2.id)
      result = Friendship.you_sent_invitation?(user1.id, user2.id)
      expect(result).to be true
    end

    it 'returns true if you got invitation for specific user' do
      Friendship.create(user_id: 1, friend_id: 2)
      result = Friendship.you_got_invitation?(1, 2)
      expect(result).to be false
    end

    it 'returns true if the two given ids have any records' do
      result = Friendship.reacted?(1, 2)
      expect(result).to be false
    end
  end
end
