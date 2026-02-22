class Category < ApplicationRecord
  belongs_to :menu
  has_many :dishes, dependent: :destroy

  validates :name, presence: true
end
