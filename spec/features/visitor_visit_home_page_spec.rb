require 'rails_helper'

feature 'User visit index page' do
  scenario 'successfully' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).to_not have_link('Nova Receita')
    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online!')
  end

  scenario 'visitor view at least one recipe' do
    # Arrange
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create(tittle: 'Pudim', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                           ingredients: 'Ovo e açucar', cook_method: 'Misture tudo')      
    # Act
    visit root_path
    # Assert
    expect(page).to have_css('h1', text: 'Pudim')
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: '60 minutos')
  end
end