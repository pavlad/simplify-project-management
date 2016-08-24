class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :mark_done]
  before_action :set_project, only: [:create, :update, :new, :edit, :index, :destroy, :mark_as_done, :unmark_as_done]

  # def index
  #   @tasks = Task.all
  # end

  # def show
  # end

  # def edit
  #   @users = User.all
  # end

  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]
    if @task.save
      respond_to do |format|
        format.html { redirect_to projects_path(project) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    end
  end

  # def new
  #   @task = Task.new
  # end

  # def update
  #   @task.update(task_params)
  #   @task.save
  # end

  # def destroy
  #   @task.destroy
  # end

  def mark_done
    @task.mark_done
    @project = Project.find(params[:project_id])
    if @task.save
      respond_to do |format|
        format.html { redirect_to projects_path(project) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    end
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
