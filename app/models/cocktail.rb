class Cocktail < ApplicationRecord
  validates :name, :picture_url, uniqueness: true, presence: true
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
end
