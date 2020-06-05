require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.new(
      name: 'Marios',
      email: 'o@o.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end
  let(:user2) do
    User.new(
      name: 'Kubilay',
      email: 'p@p.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end
  let(:friendship) do
    Friendship.create(
      user_id: 1,
      friend_id: 2,
      status: true
    )
  end

  let(:post) do
    Post.new(content: 'This is a post', user_id: 1)
  end

  describe 'validations' do
    it 'must have content' do
      expect(post).to be_valid
    end
  end

  describe 'associations' do
    it 'has many comments' do
      expect(post).to respond_to(:comments)
    end

    it 'has many likes' do
      expect(post).to respond_to(:likes)
    end
  end

  describe 'unit tests' do
    it 'returns an array of post objects for the friends' do
      Friendship.create(
        user_id: 1,
        friend_id: 2,
        status: true
      )
      Post.create(content: 'This is a post', user_id: 1)
      result = Post.visible_posts(User.last)
      expect(result).to match_array([Post.first])
    end
  end
end
