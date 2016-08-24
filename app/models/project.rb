class Project < ApplicationRecord
  # belongs_to :client
  has_many :issues
  has_many :tasks
  has_many :assignments
  has_many :users, through: :assignments
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  validates :name, presence: true
  accepts_nested_attributes_for :assignments

  def number_of_tasks
    self.tasks.size
  end

  def number_of_tasks_done
    self.tasks.select{|x| x.is_done}.count
  end

  def completion_percentage
    (self.number_of_tasks_done.to_f/self.number_of_tasks.to_f)*100
  end

end
