class User < ApplicationRecord
  has_secure_password

  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event

  has_one_attached :profile_image

  validates :name, presence: true

  validates :email, format: {with: /\S+@\S+/ },
              uniqueness: {case_sensitive: false}

  validate :acceptable_image


  private

  def acceptable_image
    return unless profile_image.attached?

    unless profile_image.blob.byte_size <= 1.megabyte
      errors.add(:profile_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_image.content_type)
      errors.add(:profile_image, "must be a JPG or PNG")
    end
  end

end
