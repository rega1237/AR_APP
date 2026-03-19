class Dish < ApplicationRecord
  belongs_to :category

  has_one_attached :photo
  has_one_attached :model_3d # .glb for Android/Web
  has_one_attached :model_usdz # .usdz for iOS

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
