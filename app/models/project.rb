class Project < ApplicationRecord
  belongs_to :client
  has_many :issues
  has_many :tasks
  has_many :consultant_projects
  has_many :consultants, through: :consultant_projects
  belongs_to :project_manager, foreign_key: :project_manager_id, class_name: :user
  validates :name, presence: true
end
