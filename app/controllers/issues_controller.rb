class IssuesController < ApplicationController
  before_action :find_project, only: [:new, :create, :destroy, :mark_as_resolved, :update]
  before_action :set_issue, only: [:update]

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
    @issue.save!
    @issue.create_activity :create, owner: current_user, project_id: @project.id
    redirect_to project_path(@project)
  end

  def edit
  end

  def update
    @issue.update(issue_params)
    @issue.create_activity :update, owner: current_user, project_id: @project.id
    redirect_to project_path(@project)
  end

  def destroy
    @issue.destroy
    @issue.create_activity :destroy, owner: current_user, project_id: @project.id
    redirect_to project_path
  end

  def mark_as_resolved
    @issue = Issue.find(params[:id])
    @issue.mark_as_resolved
    @issue.save
    if @issue.is_resolved
      @issue.create_activity :marked_as_resolved, owner: current_user, project_id: @project.id
    else
      @issue.create_activity :unmarked_as_resolved, owner: current_user, project_id: @project.id
    end
  end


  private

  def issue_params
    params.require(:issue).permit(:label, :description, :comment, :name)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

end
