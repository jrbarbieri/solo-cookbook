FactoryBot.define do
  factory :recipe do
    tittle { "Manjar" }
    recipe_type  { create(:recipe_type) }
    cuisine { "Brasileira" }
    difficulty { "Médio" }
    cook_time { 60 }
    cook_method { "Mexer tudo" }
    ingredients { "Várias coisas" }
    user { build(:user) }
  end
end