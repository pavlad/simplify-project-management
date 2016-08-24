class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, presence: true
  include PublicActivity::Model
end
