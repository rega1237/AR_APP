class Dish < ApplicationRecord
  belongs_to :category

  has_one_attached :photo
  has_one_attached :model_3d

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
