class Client < ApplicationRecord
  has_many :projects
  before_validation :smart_add_url_protocol
  validates :name, uniqueness: true, presence: true

  include AlgoliaSearch
  algoliasearch do
    attribute :name, :phone, :address, :website, :email
  end

  protected

  def smart_add_url_protocol
    unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
      self.website = "http://#{self.website}"
    end
  end
end
