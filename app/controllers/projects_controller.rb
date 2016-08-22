class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :create, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
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
    params.require(:project).permit(:name, :descritpion, :man_days, :project_manager_id, :client_id, )
  end

end
