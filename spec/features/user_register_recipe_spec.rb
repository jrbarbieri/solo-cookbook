require 'rails_helper'

feature 'User register a recipe' do
  scenario 'Sign in first' do
    #Arrange
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(tittle: 'Cuzcuz', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                            ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Nova Receita'

  end

  scenario 'successfully' do
    # Arrange
    RecipeType.create(name: 'Sobremesa')
    user = User.create!(email: 'email@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Nova Receita'

    fill_in 'Nome', with: 'Bolo de Chocolate'
    select 'Sobremesa', from: 'Tipo de receita'
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
    user = User.create!(email: "email@email.com", password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create(tittle: 'Pudim', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                           ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)

    # Act
    visit root_path
    click_on 'Pudim'
    click_on 'Editar Receita'

    fill_in 'Nome', with: 'Bolo de Chocolate'
    #fill_in 'Tipo de receita', with: 'Sobremesa'
    select 'Sobremesa', from: 'Tipo de receita'
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

  scenario 'recipes should not be registered with blank fields' do
    # Arrange
    RecipeType.create!(name: 'Sobremesa')
    user = User.create!(email: 'email@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Nova Receita'

    fill_in 'Nome', with: ''
    select 'Sobremesa', from: 'Tipo de receita'
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de cozimento', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Modo de Preparo', with: ''
    click_on 'Enviar'
  
    # Assert
    expect(page).to have_content('Campo obrigatório!')
  end

  scenario 'and user register recipe in his name' do
    # Arrange
    RecipeType.create!(name: 'Sobremesa')
    user = User.create!(email: 'email@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Nova Receita'
    fill_in 'Nome', with: 'Bolo de Chocolate'
    select 'Sobremesa', from: 'Tipo de receita'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de cozimento', with: 30
    fill_in 'Ingredientes', with: 'Farinha e chocolate'
    fill_in 'Modo de Preparo', with: 'Misture tudo'
    click_on 'Enviar'

    # Assert
    expect(page).to have_css('h1', text: 'Bolo de Chocolate')
    expect(page).to have_css('p', text: "Receita enviada por #{user.email}.")
  end

  scenario 'and user cannot edit to blank fields' do
      # Arrange
      user = User.create!(email: "email@email.com", password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
      recipe = Recipe.create!(tittle: 'Pudim', recipe_type: recipe_type,
                             cuisine: 'Brasileira', difficulty: 'Fácil', cook_time: 60,
                             ingredients: 'Ovo e açucar', cook_method: 'Misture tudo', user: user)
  
      # Act
      visit root_path
      click_on 'Pudim'
      click_on 'Editar Receita'
  
      fill_in 'Nome', with: ''
      click_on 'Enviar'
  
      # Assert
      expect(page).to have_content('Não foi possível salvar a receita')
    end
end