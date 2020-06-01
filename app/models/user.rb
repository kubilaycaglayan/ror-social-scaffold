class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :invitations, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :pending_invitations, -> { where status: false }, class_name: 'Friendship', foreign_key: 'receiver_id'

  def send_invitation(receiver)
    invitations.create(receiver_id: receiver.id)
  end

  def destroy_pending_invitation(sender)
    pending_invitation = pending_invitations.where(sender_id: sender.id)
    pending_invitation.destroy(pending_invitation.ids[0])
  end

  def accept_pending_invitation(sender)
    received_invitation = pending_invitations.where(sender_id: sender.id).first
    received_invitation.status = true
    received_invitation.save
  end

  def check_invitation(sender_id, receiver_id)
    Friendship.all.where(sender_id: sender_id, receiver_id: receiver_id).exists?
  end
end
