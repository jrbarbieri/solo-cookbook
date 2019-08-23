class Recipe < ApplicationRecord
  belongs_to :recipe_type

  validates :tittle, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: { message: 'Campo obrigatório!'}
  
  def cook_time_min
    return "#{self.cook_time} minutos"
  end
end
