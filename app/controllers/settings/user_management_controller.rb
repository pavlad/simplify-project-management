class Settings::UserManagementController < ApplicationController
  def index
    @users = User.where.not(is_client: true)
    @is_client_users = User.where(is_client: true)
  end
end
