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
    sender = User.find(params[:sender_id])
    current_user.accept_pending_invitation(sender)

    redirect_to user_path
  end

  def destroy
    invitation = Friendship.find(params[:invitation_id])
    invitation.destroy

    redirect_to user_path
  end
end
