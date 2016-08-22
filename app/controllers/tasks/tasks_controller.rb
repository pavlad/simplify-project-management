class Tasks::TasksController < ApplicationController

  def index
    @tasks = current_user.tasks
  end

  private

  def task_params
    params.require(:task).permit(:name, :project_id, :start_date, :end_date, :user_id, :is_done, :comment)
  end
end
