class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :xeditable?
  # Pundit: white-list approach.

  def xeditable? object = nil
    true # Or something like current_user.xeditable?
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

end
