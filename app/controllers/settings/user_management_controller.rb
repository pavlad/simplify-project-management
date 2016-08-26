class Settings::UserManagementController < ApplicationController
  def index
    @users = User.where.not(last_sign_in_at: nil)
    @pending_user_invitations = User.where(invitation_accepted_at: nil, last_sign_in_at: nil, is_client: false)
    @is_client_users =User.where(is_client: true)
  end
end
