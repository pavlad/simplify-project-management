class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.all
    @project = Project.new
    @users = User.all
    @project.assignments.build
  end

  def show
    @consultants = @project.users
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

    redirect_to projects_path
  end

  def edit
  end

  def update
    @project.update(project_params)
  end

  def destroy
    @project.destroy
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name,  :description, :man_days, :project_manager_id)
  end

  def assignments_params
    params.require(:project).permit!
  end

end
