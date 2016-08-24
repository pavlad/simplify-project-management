class DeliverablesController < ApplicationController
  def destroy
    @project = Project.find(params["project_id"])
    @deliverable = @project.deliverables.find(params[:id])
    @deliverable.destroy
    redirect_to project_path(@project)
  end
end
