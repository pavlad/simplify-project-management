class RegistrationsController < Devise::RegistrationsController
  def update
    # old params
    # account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @user = User.find(current_user.id)

    if needs_password?
      successfully_updated = @user.update_with_password(account_update_params)
    else
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
      account_update_params.delete('current_password')
      successfully_updated = @user.update_attributes(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      bypass_sign_in(@user)
      redirect_to edit_user_registration_path
    else
      render 'edit'
    end
  end

  private

  def needs_password?
    @user.email != params[:user][:email] || params[:user][:password].present?
  end

  def account_update_params
    params.require(:user).permit(:email, :first_name, :last_name, :job_title, :mobile_phone, :phone, :description, :is_owner, :avatar)
  end
end
