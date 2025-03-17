class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :found_item
  validates :status, presence: true, inclusion: { in: ["pending", "approved", "rejected"] }
end
