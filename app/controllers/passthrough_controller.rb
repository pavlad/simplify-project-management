class PassthroughController < ApplicationController
  def index
    if current_user.is_client
      path = client_dashboard_index_path
    else
      path = overview_dashboard_index_path
    end
    redirect_to path
  end
end
