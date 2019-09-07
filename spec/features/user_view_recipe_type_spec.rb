require 'rails_helper'

feature 'User visit index page' do
  scenario 'and view recipe type' do
    # Arrange
    #user = User.create!(email: 'email@email.com', password: '123456')
    #recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = create(:recipe, tittle: 'Cuzcuz')
    # recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
    #                         cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
    #                         ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)

    # Act
    visit root_path

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).to have_css('li', text: 'Sobremesa')
  end

  scenario 'and view recipe type in details page' do
    # Arrange
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                            ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)

    # Act
    visit root_path
    click_on 'Cuzcuz'

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).to have_css('li', text: 'Sobremesa')
  end
end