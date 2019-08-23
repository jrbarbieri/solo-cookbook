class RecipeType < ApplicationRecord
  has_many :recipes

  validates :name, presence: { message: 'Campo obrigatório!' }
  validates :name, uniqueness: { message: 'Campo duplicado!' }
end
