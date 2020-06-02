class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'friend_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, uniqueness: { scope: :friend_id, message: 'Unique Friendship' }
end
