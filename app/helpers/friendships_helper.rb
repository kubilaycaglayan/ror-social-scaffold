module FriendshipsHelper
  def invitation_button(user)
    return if user == current_user || current_user.check_invitation(current_user.id, user.id)

    if current_user.check_invitation(user.id, current_user.id)
      # render invitation is waiting for you to accept or reject
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
