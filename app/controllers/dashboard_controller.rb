class DashboardController < ApplicationController

  def index
  end

  def overview
    # projects overview
    @projects = active_projects
    @number_of_active_projects = @projects.count
    @project_with_issues = projects_with_issues(@projects)

    # consultants overview

    @consultants = User.all
    @consultants_with_tasks = consultants_with_tasks(@consultants)

  end

  private

  def active_projects
    Project.where(active: true)
  end

  def projects_with_issues(projects)
    projects.select{ |project| project.has_issues?}.count
  end

  def consultants_with_tasks(consultants)
    consultants.select{ |consultant| consultant.has_tasks?}.count
  end

end
