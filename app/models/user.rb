class User < ApplicationRecord
  # Add :database_authenticatable back!
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :lost_items
  has_many :found_items
  has_many :claims
  has_many :notifications
  has_many :reports
  has_one_attached :profile_image

  # Only allow UTRGV emails
  validates :email, presence: true, uniqueness: true




  # 🔻 Disable UTRGV-only check for testing
  # validate :email_domain_must_be_utrgv

  # def email_domain_must_be_utrgv
  #   unless email.to_s.downcase.ends_with?("@utrgv.edu")
  #     errors.add(:email, "must be a UTRGV email")
  #   end
  # end


  def active_for_authentication?
    super && !disabled?
  end
  
  def inactive_message
    disabled? ? :locked : super
  end
  
  has_one_attached :profile_image

  validate :profile_image_must_be_image
  
  def profile_image_must_be_image
    return unless profile_image.attached?
    unless profile_image.content_type.in?(%w[image/png image/jpeg image/jpg image/webp])
      errors.add(:profile_image, "must be a valid image format (PNG, JPG, JPEG, or WEBP)")
      profile_image.purge # Optional: deletes it immediately
    end
  end
  
  # Skip password validation for UTRGV code login
  def password_required?
    false
  end
 
  # Add virtual attribute (optional for display)
  attr_accessor :entered_code

  # Check code match
  def verify_code_matches?(input)
    self.verification_code.present? && self.verification_code == input.to_s.upcase.strip
  end
end