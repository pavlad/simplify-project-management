class TimelinesController < ApplicationController
  before_action :set_timeline, only: [:edit, :update, :destroy]

  def index
    @timelines = Timeline.all
  end

  def new
    @timeline = Timeline.new
  end

  def create
    @timeline = Timeline.new(timeline_params)
    @timeline.user = current_user
    @timeline.save

    redirect_to timelines_path
  end

  def edit
  end

  def update
    @timeline = Timeline.update(timeline_params)
    redirect_to timelines_path
  end

  def destroy
    @timeline.destroy
    redirect_to timelines_path
  end

  private

  def timeline_params
    params.require(:timeline).permit(:title, :date, :description, :user)
  end

  def set_timeline
    @timeline = Timeline.find(params[:id])
  end

end
