require 'rails_helper'

feature 'User visit cookbook' do
  scenario 'and view recipe type' do
    # Arrange
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Pudim', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                           ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)

    # Act
    visit root_path
    click_on 'Pudim'

    # Assert
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Ovo e açucar')
    expect(page).to have_css('h3', text: 'Modo de Preparo')
    expect(page).to have_css('p', text: 'Misture tudo')

  end
end