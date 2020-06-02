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
  end
end
