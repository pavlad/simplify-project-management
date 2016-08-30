class Issue < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  validates :label, inclusion: { in: ["Low Priority","Medium Priority","High Priority"] }
  include PublicActivity::Model

  include AlgoliaSearch

  algoliasearch do
    attribute :name, :label, :comment, :description
  end

  def mark_as_resolved
    if self.is_resolved
      self.is_resolved = false
    else
      self.is_resolved = true
    end
  end
end
