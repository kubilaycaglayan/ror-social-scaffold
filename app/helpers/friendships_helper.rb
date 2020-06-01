module FriendshipsHelper
  def invitation_button(user)
    return if user == current_user || current_user.check_invitation(current_user.id, user.id)

    render 'users/invite_friendship', user: user
  end
end
