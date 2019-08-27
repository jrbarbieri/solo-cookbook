require 'rails_helper'

feature 'User search for a recipe with exact name' do
  scenario 'successfully' do
    # Arrange
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                            ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)
    another_user = User.create!(email: 'another_email@email.com', password: '123456')
    another_recipe_type = RecipeType.create!(name: 'Massas')
    another_recipe = Recipe.create!(tittle: 'Macarronada', recipe_type: another_recipe_type,
                                    cuisine: 'Italiana', difficulty: 'Fácil', cook_time: 60,
                                    ingredients: 'Ovo e farinha', cook_method: 'Misture tudo', user: another_user)

    # Act
    visit root_path
    fill_in 'Buscar receitas:', with: 'Cuzcuz'
    click_on 'Buscar'

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).not_to have_css('h1', text: 'Macarronada')
  end

  scenario 'search for recipe and dont find it' do
    # Arrange

    # Act
    visit root_path
    fill_in 'Buscar receitas:', with: 'Cuzcuz'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content('Nenhuma receita encontrada.')
  end

  scenario 'search for recipe with partial name' do
    # Arrange
    user = User.create!(email: "email@email.com", password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                            ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)
    another_recipe = Recipe.create!(tittle: 'Cuzcuz Marroquino', recipe_type: recipe_type,
                                    cuisine: 'Árabe', difficulty: 'Fácil', cook_time: 60,
                                    ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)

    # Act
    visit root_path
    fill_in 'Buscar receitas:', with: 'Cuzcuz'
    click_on 'Buscar'

    # Assert
    expect(page).to have_css('h1', text: 'Cuzcuz')
    expect(page).to have_css('h1', text: 'Cuzcuz Marroquino')
  end
end