class UsersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :show_consultant]

  def index
    @users = User.all
  end

  def edit
    respond_to do |format|
        format.html { redirect_to users_path() }
        format.js
      end
  end

  def show
    @projects = @user.projects.select{|project| project.has_consultant(@user)}
  end

  def update
    @user.update(user_params)

    redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def show_consultant
    respond_to do |format|
      format.html { redirect_to users_path() }
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :job_title, :mobile_phone, :phone, :description, :is_owner, :avatar )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
