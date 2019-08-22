require 'rails_helper'

feature 'User visit cookbook' do
  scenario 'and view recipe details' do
    # Arrange
    recipe = Recipe.create(tittle: 'Pudim', recipe_type: 'Sobremesa',
                           cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                           ingredients: 'Ovo e açucar', cook_method: 'Misture tudo')

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