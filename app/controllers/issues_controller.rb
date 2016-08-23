class IssuesController < ApplicationController
  before_action :find_project, only: [:new, :create, :destroy]

  def index
    @issues = Issue.all
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = @project.issues.build(issue_params)
    @issue.save
    redirect_to project_path(@project)
  end

  def edit
  end

  def update
    @issue.update(issue_params)
    redirect_to project_path(@project)
  end

  def destroy
    @issue.destroy
    redirect_to project_path
  end

  def mark_as_resolved
    @issue.is_resolved = true
  end

  def undo_mark_as_resolved
    @issue.is_resolved = true
  end

  private

  def issue_params
    params.require(:issue).permit(:label, :description, :comment)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

end
