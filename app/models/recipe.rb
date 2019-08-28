class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user

  validates :tittle, :user, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: { message: 'Campo obrigatório!'}
  
  def cook_time_min
    return "#{self.cook_time} minutos"
  end

  def form_date(date)
    # formatting date: Aug, 31 2007 - 9:55PM
    date.strftime("%d/%m/%Y às %H:%M")
  end
end
