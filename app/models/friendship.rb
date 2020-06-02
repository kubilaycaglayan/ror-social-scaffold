class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: 'sender_id'
  belongs_to :user, foreign_key: 'receiver_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  validates :sender_id, uniqueness: { scope: :receiver_id, message: 'Unique Friendship' }
end
