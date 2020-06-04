class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    sign_in @user
    redirect_to user_path(id: current_user.id)
  end

  def destroy
    sign_out current_user
    redirect_to root_path
  end
end
