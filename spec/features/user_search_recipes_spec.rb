require 'rails_helper'

feature 'User search for a recipe with exact name' do
  scenario 'successfully' do
    # Arrange
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
      ingredients: 'Ovo e açucar', cook_method: 'Misture tudo')
    another_recipe_type = RecipeType.create!(name: 'Massas')
    another_recipe = Recipe.create!(tittle: 'Macarronada', recipe_type: another_recipe_type,
                            cuisine: 'Italiana', difficulty: 'Fácil', cook_time: 60,
                            ingredients: 'Ovo e farinha', cook_method: 'Misture tudo')

    # Act
    visit root_path
    fill_in 'Buscar receitas', with: 'Cuzcuz'
    click_in 'Buscar'

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).not_to have_css('h1', text: 'Macarronada')
  end
end