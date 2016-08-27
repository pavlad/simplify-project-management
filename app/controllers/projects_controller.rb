class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :update, :destroy]
  before_action :load_activities, only: [:show]

  def index
    @projects = Project.all
    @project = Project.new
    @users = User.all
    @clients = Client.all
    @project.assignments.build
  end

  def show
    @consultants = @project.users
    @users = User.all
    @task = Task.new
    @tasks = @project.tasks
    @task_count = @project.tasks.count
    @percentage = @project.completion_percentage
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
    assignments_params[:user_ids].drop(1).each do |user_id|
      @project.assignments.build(user_id: user_id)
    end
    @project.save
    @project.create_activity :create, owner: current_user, project_id: @project.id
    @project.assignments.each do |consultant|
      @project.create_activity :assign, owner: current_user, project_id: @project.id, assignment_consultant_id: consultant.user_id
    end
    redirect_to project_path(@project)
  end

  def edit

  end

  def update
    @project.update(project_params)
    if @project.save
      respond_to do |format|
        format.html { redirect_to project_path(@project) }
        format.json { render json: @project }
      end
    end
    @project.create_activity :update, owner: current_user, project_id: @project.id
  end

  def destroy
    @project.destroy
    @project.create_activity :destroy, owner: current_user, project_id: @project.id
  end

  def render_timeline
    @project = Project.find(8)
    respond_to do |format|
      format.html { redirect_to project_path(params[:project_id]) }
      format.js
    end
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :man_days, :project_manager_id, :client_id, :user_id, deliverables: [], project_files: [])
  end

  def assignments_params
    params.require(:project).permit!
  end

  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').where(project_id: @project.id)
  end

end
