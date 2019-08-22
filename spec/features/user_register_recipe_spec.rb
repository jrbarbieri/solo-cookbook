require 'rails_helper'

feature 'User register a recipe' do
  scenario 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Nova Receita'

    fill_in 'Nome', with: 'Bolo de Chocolate'
    fill_in 'Tipo de receita', with: 'Sobremesa'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de cozimento', with: 30
    fill_in 'Ingredientes', with: 'Farinha e chocolate'
    fill_in 'Modo de Preparo', with: 'Misture tudo'
    click_on 'Enviar'

    # Assert
    expect(page).to have_css('h1', text: 'Bolo de Chocolate')
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: '30 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Farinha e chocolate')
    expect(page).to have_css('h3', text: 'Modo de Preparo')
    expect(page).to have_css('p', text: 'Misture tudo')
  end

  scenario 'and user can edit the recipe' do
    # Arrange
    recipe = Recipe.create(tittle: 'Pudim', recipe_type: 'Sobremesa',
                           cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                           ingredients: 'Ovo e açucar', cook_method: 'Misture tudo')

    # Act
    visit root_path
    click_on 'Pudim'
    click_on 'Editar Receita'

    fill_in 'Nome', with: 'Bolo de Chocolate'
    fill_in 'Tipo de receita', with: 'Sobremesa'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de cozimento', with: 30
    fill_in 'Ingredientes', with: 'Farinha e chocolate'
    fill_in 'Modo de Preparo', with: 'Misture tudo'
    click_on 'Enviar'

    # Assert
    expect(page).to have_css('h1', text: 'Bolo de Chocolate')
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Fácil')
    expect(page).to have_css('li', text: '30 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Farinha e chocolate')
    expect(page).to have_css('h3', text: 'Modo de Preparo')
    expect(page).to have_css('p', text: 'Misture tudo')
    expect(page).to have_link('Voltar')
  end
end