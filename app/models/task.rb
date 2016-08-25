class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, presence: true
  include PublicActivity::Model

  include AlgoliaSearch

  algoliasearch do
    attribute :name, :comment
  end

  def mark_done
    if self.is_done
      self.is_done = false
    else
      self.is_done = true
    end
  end

end
