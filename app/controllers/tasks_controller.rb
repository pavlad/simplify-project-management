class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :update, :new, :edit, :index, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
    @users = User.all

  end

  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]
    @task.save

    redirect_to project_tasks_path(@project)
  end

  def new
    @task = Task.new
    redirect_to project_tasks_path(@project)
  end

  def update
    @task.update(task_params)
    @task.save

    redirect_to project_tasks_path(@project)
  end

  def destroy
    @task.destroy

    redirect_to project_tasks_path(@project)
  end

  private

  def task_params
    params.require(:task).permit(:name, :project_id, :start_date, :end_date, :user_id, :is_done, :comment)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
