class Issue < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  include PublicActivity::Model

  def mark_as_resolved
    if self.is_resolved
      self.is_resolved = false
    else
      self.is_resolved = true
    end
  end
end
