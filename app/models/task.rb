class Task < ApplicationRecord
  after_initialize :default_value

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

  def has_date?
    self.start_date == nil || self.end_date == nil ? false : true
  end

  def color
    if self.is_done
      return "#177F75"
    else
      return "#B6212D"
    end
  end

  private
  def default_value
    self.is_done ||= false
  end
end
