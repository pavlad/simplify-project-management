class ProjectsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :find_project, only: [:show, :update, :destroy]
  before_action :load_activities, only: [:show]

  def index
    @projects = Project.all
    @project = Project.new
    @users = User.all
    @project.assignments.build
  end

  def show
    @consultants = @project.users
    @task = Task.new
    @tasks = Task.all
  end

  def new
    @users = User.all
    @project = Project.new
    @project.assignments.build
  end

  def create
    @project = Project.new(project_params)
    @project.save

    # project_params[:assignments_attributes]['0'][:user_id].each do |user_id|
    #   assign = @project.assignments.build(user_id: user_id)
    #   assign.save!
    # end
    assignments_params[:assignments_attributes]["0"][:user_id].drop(1).each do |user_id|
      @project.assignments.build(user_id: user_id)
    end
    @project.save
    @project.create_activity :create, owner: current_user, project_id: @project.id
    @project.assignments.each do |consultant|
      @project.create_activity :assign, owner: current_user, project_id: @project.id, assignment_consultant_id: consultant.user_id
    end
    redirect_to projects_path
  end

  def edit

  end

  def update
    @project.update(project_params)
    @project.create_activity :update, owner: current_user, project_id: @project.id
    redirect_to project_path(@project)
  end

  def destroy
    @project.destroy
    @project.create_activity :destroy, owner: current_user, project_id: @project.id
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name,  :description, :man_days, :project_manager_id, deliverables: [], project_files: [])
  end

  def assignments_params
    params.require(:project).permit!
  end

  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').where(project_id: @project.id)
  end

end
