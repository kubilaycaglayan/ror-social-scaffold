class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'friend_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, uniqueness: { scope: :friend_id, message: 'Unique Friendship' }

  def self.you_sent_invitation?(id1, id2)
    !Friendship.all.where(user_id: id1, friend_id: id2, status: false).empty?
  end

  def self.you_got_invitation?(id2, id1)
    !Friendship.all.where(user_id: id1, friend_id: id2, status: false).empty?
  end

  def self.reacted?(id1, id2)
    case1 = you_sent_invitation(id1, id2)
    case2 = you_got_invitation(id2, id1)

    case1 || case2
  end
end
