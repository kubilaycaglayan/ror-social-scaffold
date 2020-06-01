class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship
  end

  def create
    sender_id = current_user.id
    receiver_id = params[:id]
    Friendship.create(sender_id: sender_id, receiver_id: receiver_id)
  end

  def update
    puts 'INSIDE UPDATE METHOD'
    p sender = User.find(params[:sender_id])
    current_user.accept_pending_invitation(sender)
  end

  def destroy; end
end
