class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    @projects = @user.projects
  end

  def update
    @user.update(user_params)

    redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :job_title, :mobile_phone, :phone, :description, :is_owner )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
