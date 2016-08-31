class Client::DashboardController < ApplicationController

  def index
    @projects = current_user.projects

  end


  private

  def active_projects
    current_user.projects.where(active: true)
  end

end
