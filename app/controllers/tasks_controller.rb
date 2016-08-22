class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :update]

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.save

    redirect_to project_task(@project, @task)
  end

  def new
    @task = Task.new
  end

  def update
    @task.update(task_params)

    redirect_to project_task(@project, @task)
  end

  def destroy
    @task.destroy

    redirect_to tasks_path
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
