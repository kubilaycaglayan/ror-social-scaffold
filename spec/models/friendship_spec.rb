require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) do
    User.new(
      name: 'Marios',
      email: 'b@b.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end

  describe 'associations' do
    it 'belongs to a user' do
    end
  end
end
