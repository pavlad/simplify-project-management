class PassthroughController < ApplicationController
  def index
    if current_user.is_client
      path = client_dashboard_index_path
    else
      path = projects_path
    end
    redirect_to path
  end
end
