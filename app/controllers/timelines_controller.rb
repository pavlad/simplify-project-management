class TimelinesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_timeline, only: [:edit, :update, :destroy, :show]
  before_action :set_project, only: [:new, :create, :index, :show, :edit, :update, :destroy, :invite_client]

  def index
    @timelines = Timeline.where(project_id: params[:project_id])
  end

  def show
    respond_to do |format|
      format.html { redirect_to timelines_path() }
      format.js
    end
  end

  def new
    @timeline = Timeline.new
  end

  def create
    @timeline = Timeline.new(timeline_params)
    @timeline.user = current_user
    unless @timeline.date.nil?
      @timeline.date = Date.parse(timeline_params[:date])
    end
    @timeline.project_id = params[:project_id]
    @timeline.save!

    redirect_to project_timelines_path
  end

  def edit
    respond_to do |format|
      format.html { redirect_to project_timelines_path(@project) }
      format.js
    end
  end

  def update
    my_params = timeline_params
    my_params[:date] = Date.parse(timeline_params[:date])
    @timeline = Timeline.update(my_params)
    redirect_to project_timelines_path(@project)
  end

  def destroy
    @timeline.destroy
    redirect_to project_timelines_path(@project)
  end

  def invite_client
    invited_client = User.invite!(email: params["timeline"][:email], is_client: true)
    @project.assignments.create(user_id: invited_client.id)
    redirect_to project_timelines_path(@project)
  end

  private

  def timeline_params
    params.require(:timeline).permit(:title, :date, :description, :user)
  end

  def set_timeline
    @timeline = Timeline.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
