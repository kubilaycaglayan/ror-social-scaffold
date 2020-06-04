class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :invitations, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_invitations, -> { where status: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  def send_invitation(receiver)
    invitations.create(friend_id: receiver.id)
  end

  def destroy_pending_invitation(sender)
    pending_invitation = pending_invitations.where(user_id: sender.id)
    pending_invitation.destroy(pending_invitation.ids[0])
  end

  def accept_pending_invitation(sender)
    received_invitation = pending_invitations.where(user_id: sender.id).first
    received_invitation.status = true
    received_invitation.save

    new_invitation = Friendship.new(user_id: id, friend_id: sender.id, status: true)
    new_invitation.valid?
    new_invitation.save
  end

  def check_invitation(id1, id2)
    Friendship.all.where(user_id: id1, friend_id: id2).exists?
  end

  def friends
    invitations.where(user_id: id, status: true).pluck(:friend_id)
  end

  def friend_with?(user)
    friends.include?(user.id)
  end

  def friends
    friends_i_send_invitation = Friendship.all.where(sender_id: id, status: true).pluck(:receiver_id)
    friends_who_send_invitation_to_me = Friendship.all.where(receiver_id: id, status: true).pluck(:sender_id)
    all_friends = friends_i_send_invitation + friends_who_send_invitation_to_me
    all_friends.uniq
  end
end
