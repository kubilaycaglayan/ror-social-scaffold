module FriendshipsHelper
  def invitation_button(user)
    return if user == current_user || current_user.check_invitation(current_user.id, user.id)

    if current_user.check_invitation(user.id, current_user.id)
      record = Friendship.where(sender_id: user.id, receiver_id: current_user.id)[0]
      render 'friendships/this_user_sent_you_an_invitation' unless record.status
    else
      render 'users/invite_friendship', user: user
    end
  end

  def show_pending_invitations(user)
    return unless user == current_user

    render 'friendships/pending_invitations'
  end

  def show_accept_buttons(invitation)
    render 'friendships/show_accept_buttons', invitation: invitation
  end
end
