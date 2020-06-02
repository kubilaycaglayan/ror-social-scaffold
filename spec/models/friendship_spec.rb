require 'rails_helper'

RSpec.describe Friendship, type: :model do
  User.create(
    name: 'Marios',
    email: 'b@b.com',
    password: '000000',
    password_confirmation: '000000'
  )
  User.create(
    name: 'Kubilay',
    email: 'a@a.com',
    password: '000000',
    password_confirmation: '000000'
  )

  let(:friendship) { Friendship.new(user_id: 1, friend_id: 2) }

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
      Friendship.create(user_id: 1, friend_id: 2)
      expect(friendship).not_to be_valid
    end
  end

  describe 'has two row approach' do
    it 'creates a mirror row when invitation is accepted' do
      Friendship.create(user_id: 2, friend_id: 1)
      User.first.accept_pending_invitation(User.last)
      record = Friendship.where(user_id: User.first.id, friend_id: User.last.id, status: true)
      expect(record.empty?).not_to be true
    end
  end
end
