class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true

  validates :reason, presence: true
end
