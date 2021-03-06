class ProjectFilesController < ApplicationController
  skip_before_filter :authenticate_user!
  def destroy
    @project = Project.find(params["project_id"])
    @project_file = @project.project_files.find(params[:id])
    @project_file.destroy
    redirect_to project_path(@project)
  end
end
