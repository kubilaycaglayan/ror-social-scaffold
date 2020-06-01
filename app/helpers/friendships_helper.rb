module FriendshipsHelper
  def invitation_button(user)
    return if user == current_user || current_user.check_invitation(current_user.id, user.id)

    render 'users/invite_friendship', user: user
  end

  def show_pending_invitations(user)
    return unless user == current_user

    render 'friendships/pending_invitations'
  end

  def show_accept_buttons(sender_id)
    render 'friendships/show_accept_buttons', sender_id: sender_id
  end
end
