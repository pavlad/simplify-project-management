class Issue < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  include PublicActivity::Model
end
