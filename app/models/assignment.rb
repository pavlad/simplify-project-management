class Assignment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:project_id]
  accepts_nested_attributes_for :user

end
