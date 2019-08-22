class Recipe < ApplicationRecord

  def cook_time_min
    return "#{self.cook_time} minutos"
  end
end
