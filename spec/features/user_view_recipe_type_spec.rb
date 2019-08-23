require 'rails_helper'

feature 'User visit index page' do
  scenario 'and view recipe type' do
    # Arrange
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create(tittle: 'Cuzcuz', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
      ingredients: 'Ovo e açucar', cook_method: 'Misture tudo')

    # Act
    visit root_path

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).to have_css('li', text: 'Sobremesa')
  end

  scenario 'and view recipe type in details page' do
    # Arrange
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
      cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
      ingredients: 'Ovo e açucar', cook_method: 'Misture tudo')

    # Act
    visit root_path
    click_on 'Cuzcuz'

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).to have_css('li', text: 'Sobremesa')
  end
end