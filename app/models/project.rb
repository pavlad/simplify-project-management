class Project < ApplicationRecord
  # belongs_to :client
  has_many :issues
  has_many :tasks
  has_many :assignments
  has_many :users, through: :assignments
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  validates :name, presence: true
  accepts_nested_attributes_for :assignments

  has_attachments :deliverables, maximum: 20
  has_attachments :project_files, maximum: 20
  include PublicActivity::Model
end


