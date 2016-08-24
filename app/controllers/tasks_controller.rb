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
    @task.create_activity :create, owner: current_user, project_id: @project.id
  end


  # def update
  #   @task.update(task_params)
  #   @task.save
  #   @project.create_activity :update, owner: current_user, project_id: @project.id
  # end

  # def destroy
  #   @task.destroy
  #   @project.create_activity :destroy, owner: current_user, project_id: @project.id
  # end

  def mark_done
    @task.mark_done
    if @task.save
      respond_to do |format|
        format.html { redirect_to projects_path(project) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    end
    # STILL HAVE TO FIGURE OUT WHY THIS IS NOT WORKING
    # if @task.is_done
    #   @task.create_activity :marked_as_done, owner: current_user, project_id: @project.id
    # else
    #   @task.create_activity :unmarked_as_done, owner: current_user, project_id: @project.id
    # end
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
