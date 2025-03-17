class User < ApplicationRecord
  has_secure_password
  has_many :lost_items
  has_many :found_items
  has_many :claims
  has_many :notifications
  has_many :reports

  validates :email, presence: true, uniqueness: true
end
