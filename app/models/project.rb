class Project < ApplicationRecord
  # belongs_to :client
  has_many :issues
  has_many :tasks, dependent: :destroy
  has_many :assignments
  has_many :users, through: :assignments
  belongs_to :client
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  has_one :timelines, dependent: :destroy
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
end
