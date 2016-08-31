class DashboardController < ApplicationController

  def index
  end

  def overview
    # projects overview
    @projects = active_projects
    @number_of_active_projects = @projects.count
    @project_with_issues = projects_with_issues(@projects)
    @total_undone_tasks = total_tasks(@projects) - total_tasks_done(@projects)
    @overdue_projects_count = overdue_projects_count(@projects)

    # consultants overview

    @consultants = User.all
    @consultants_with_tasks = consultants_with_tasks(@consultants)
    @average_tasks = @total_undone_tasks / @consultants_with_tasks

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

  def total_tasks(projects)
    projects.map{ |project| project.number_of_tasks}.inject(0){|sum,x| sum + x }
  end

  def total_tasks_done(projects)
    projects.map{ |project| project.number_of_tasks_done}.inject(0){|sum,x| sum + x }
  end

  def overdue_projects_count(projects)
    projects.select{|project| project.overdue?}.count
  end


end
