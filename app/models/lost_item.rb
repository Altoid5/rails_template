class LostItem < ApplicationRecord
  belongs_to :user
  has_many :reports, as: :post

  has_one_attached :image

  validates :name, :description, :location, :category, presence: true
end
