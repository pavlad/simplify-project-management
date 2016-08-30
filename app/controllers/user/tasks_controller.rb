class User::TasksController < ApplicationController

  def index
    @tasks = current_user.tasks
  end

  def mark_done
    @task = Task.find(params[:task_id])
    if @task.is_done == false
      @task.is_done = true
    else
      @task.is_done = false
    end
    if @task.save
      respond_to do |format|
        format.html { redirect_to user_tasks_path }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :project_id, :start_date, :end_date, :user_id, :is_done, :comment)
  end
end
