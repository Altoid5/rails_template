class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :found_item
end
