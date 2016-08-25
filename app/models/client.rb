class Client < ApplicationRecord
  has_many :projects
  validates :name, uniqueness: true, presence: true

  include AlgoliaSearch
  algoliasearch do
    attribute :name, :phone, :address, :website, :email
  end
end
