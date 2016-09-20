class TimelineFilesController < ApplicationController
  def destroy
    @timeline = Timeline.find(params["timeline_id"])
    @timeline_file = @timeline.timeline_files.find(params[:id])
    @timeline_file.destroy
    redirect_to project_timelines_path(@timeline.project)
  end
end
