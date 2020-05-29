class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship
  end

  def create
    sender_id = current_user.id
    receiver_id = params[:id]
    Friendship.create(sender_id: sender_id, receiver_id: receiver_id)
  end

  def update; end

  def destroy; end
end
