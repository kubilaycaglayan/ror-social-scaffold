class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: 'sender_id'
  belongs_to :user, foreign_key: 'receiver_id'
end
