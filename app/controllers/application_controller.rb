class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :xeditable?

  def xeditable? object = nil
    true # Or something like current_user.xeditable?
  end
end
