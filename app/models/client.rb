class Client < ApplicationRecord
  has_one_attached :logo
  has_many :menus, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/, message: "only allows lowercase letters, numbers and hyphens" }
  validates :contact_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :api_token, uniqueness: true, allow_nil: true

  before_validation :generate_api_token, on: :create
  before_validation :generate_slug, on: :create

  private

  def generate_api_token
    self.api_token ||= SecureRandom.hex(20)
  end

  def generate_slug
    self.slug = name.parameterize if slug.blank? && name.present?
  end
end
