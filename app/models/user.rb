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

  def friend_with?(user)
    friends.include?(user.id)
  end

  def friends
    friends_i_send_invitation = Friendship.all.where(user_id: id, status: true).pluck(:friend_id)
    friends_who_send_invitation_to_me = Friendship.all.where(friend_id: id, status: true).pluck(:user_id)
    all_friends = friends_i_send_invitation + friends_who_send_invitation_to_me
    all_friends.uniq
  end

  def self.find_or_create_from_auth_hash(auth)
  where(id: auth.uid.to_s[0..9].to_i).first_or_initialize.tap do |user|
    # user.provider = auth.provider
    # user.uid = auth.uid
      user.id = auth.uid.to_s[0..9].to_i
    # user.first_name = auth.info.first_name
    # user.last_name = auth.info.last_name
      user.name = auth.info.first_name + " " + auth.info.last_name
      user.email = auth.info.email
    # user.picture = auth.info.image
      user.password = "000000"
      user.password_confirmation = "000000"
      user.save!
  end
end
end
