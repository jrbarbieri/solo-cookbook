require 'rails_helper'

feature 'User can view my recipes button only if his is signed in' do
  scenario 'successfully' do
    #Arrange

    #Act
    visit root_path

    #Assert
    expect(page).to_not have_link('Minhas Receitas')

  end

  scenario 'and user can only see his recipes if he clicks on my recipes button' do
    #Arrange
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


    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas Receitas'

    #Assert
    expect(page).to have_link(recipe.tittle)
  end
end