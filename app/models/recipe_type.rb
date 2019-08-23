class RecipeType < ApplicationRecord
  validates :name, presence: { message: 'Campo obrigatório!'}
  has_many :recipes
end
