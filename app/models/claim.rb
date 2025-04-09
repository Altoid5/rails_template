class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :found_item
  validates :answer, presence: true
  validates :status, presence: true, inclusion: { in: [ "pending", "approved", "rejected" ] }
end
