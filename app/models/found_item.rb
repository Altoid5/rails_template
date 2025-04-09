class FoundItem < ApplicationRecord
  belongs_to :user
  has_many :claims
  has_many :reports, as: :post

  has_one_attached :image

  validates :name, :description, :location, :category, presence: true
  validate :image_must_be_valid

  private

  def image_must_be_valid
    return unless image.attached?
    unless image.content_type.in?(%w[image/png image/jpeg image/jpg image/webp])
      errors.add(:image, "must be a valid image format (PNG, JPG, JPEG, or WEBP)")
      image.purge
    end
  end
end
