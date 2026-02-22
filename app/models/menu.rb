class Menu < ApplicationRecord
  belongs_to :client
  has_many :categories, dependent: :destroy
  has_many :dishes, through: :categories

  validates :name, presence: true
end
