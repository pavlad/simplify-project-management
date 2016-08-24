class DeliverablesController < ApplicationController
  skip_before_filter :authenticate_user!
  def destroy
    @project = Project.find(params["project_id"])
    @deliverable = @project.deliverables.find(params[:id])
    @deliverable.destroy
    redirect_to project_path(@project)
  end
end
