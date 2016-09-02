class Project < ApplicationRecord
  after_initialize :default_values
  # belongs_to :client
  has_many :issues, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments
  belongs_to :client
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  has_many :timelines, dependent: :destroy
  validates :name, presence: true
  has_attachments :deliverables, maximum: 20
  has_attachments :project_files, maximum: 20
  include PublicActivity::Model
  accepts_nested_attributes_for :assignments

  include AlgoliaSearch

  algoliasearch do
    attribute :name, :description, :id
  end

  def number_of_tasks
    self.tasks.size
  end

  def number_of_tasks_done
    self.tasks.select{|x| x.is_done}.count
  end

  def completion_percentage
    (self.number_of_tasks_done.to_f/self.number_of_tasks.to_f)*100
  end

  def clients
    self.users.where(is_client: true)
  end

  def consultants
    self.users.where.not(is_client: true)
  end

  def timeline_tasks
    array = []
    self.tasks.each do |task|
      if task.has_date?
        array << [task.name, task.start_date, task.end_date]
      end
    end
    return array
  end

  def color_tasks
    array = []
    self.tasks.each do |task|
      if task.has_date?
        array << task.color
      end
    end
    return array
  end

  def has_issues?
    return self.issues.count != 0
  end

  def has_consultant(consultant)
    ans = false
    self.tasks.each do |task|
      if task.user == consultant && task.has_date?
        ans = true
      end
    end
    return ans
  end

  def issue_type
    hash = {
      "Low Priority"=>     1,
      "Medium Priority"=>  2,
      "High Priority"=>    3
    }
    if self.issues.count == 0
      return "No Issue"
    else
      value = self.issues.map{|issue| hash[issue.label] }.max
      return hash.index(value)
    end
  end

  def has_issues?
    return self.issues.select{|issue| issue.is_resolved == false}.count > 0
  end

  def status_class
    hash = {
      "No Issue"=>        "ui green label",
      "Low Priority"=>    "ui yellow label",
      "Medium Priority"=> "ui orange label",
      "High Priority"=>   "ui red label"
    }
    return hash[self.issue_type]
  end

  def has_tasks_with_date
    ans = false
    self.tasks.each do |task|
      ans = true if task.has_date?
    end
    return ans
  end

  def last_date
    if self.has_tasks_with_date
      return self.tasks.order(:end_date).select{|task| task.has_date?}.last.end_date
    end
  end

  def overdue?
    if self.has_tasks_with_date
      self.last_date < Time.now ? true : false
    else
      return false
    end
  end



  private


  def default_values
    self.active ||= true
  end

end

