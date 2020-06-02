module FriendshipsHelper
  def invitation_button(user)
    return if user == current_user
    record = Friendship.where(user_id: user.id, friend_id: current_user.id)[0]

    if current_user.check_invitation(user.id, current_user.id) && record.status == false
      render 'friendships/this_user_sent_you_an_invitation'
    elsif Friendship.all.where(user_id: current_user.id, friend_id: user.id, status: false).empty? == false
      render 'friendships/you_sent_invitation'
    elsif current_user.friend_with?(user)
      render 'friendships/is_your_friend'
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
