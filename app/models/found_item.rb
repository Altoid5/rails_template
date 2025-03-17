class FoundItem < ApplicationRecord
  belongs_to :user
  has_many :claims
  has_many :reports, as: :post

  validates :name, :description, :location, :category, presence: true
end
