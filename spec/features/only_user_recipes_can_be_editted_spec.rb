require 'rails_helper'

feature 'User update his recipes' do
  scenario '1: must be logged in' do
    #Arrange
    user = create(:user)

    #Act
    login_as(user)
    visit root_path

    #Assert
    expect(page).to have_content("Olá, #{user.email}!")
  end

  scenario '2: user can only see edit button if he owns the recipe' do
    #Arrange
    user = create(:user)
    another_user = create(:user, email: 'joao@joao.com')
    recipe = create(:recipe, user: another_user)

    #Act
    login_as(user)
    visit root_path
    click_on recipe.tittle

    #Assert
    expect(page).not_to have_link('Editar Receita')
  end

  scenario '3: if no ones if authenticated, edit button should be not visible' do
    recipe = create(:recipe)
    visit root_path
    click_on recipe.tittle
    expect(page).not_to have_link('Editar Receita')
  end

  scenario '4: if user try to access edit route without being recipe owner, it should redirect to root' do
    #Arrange
    user = create(:user)
    another_user = create(:user, email: 'joao@joao.com')
    recipe = create(:recipe, user: another_user)

    #Act
    login_as(user)
    visit edit_recipe_path(recipe)
    
    #Assert
    expect(current_path).to eq root_path
  end
end