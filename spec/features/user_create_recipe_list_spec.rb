require 'rails_helper'

feature 'User can create a recipe list' do
  scenario '1: user can not create a list if he is not signed in' do
    #Act
    visit root_path

    #Assert
    expect(page).to_not have_link('Nova Lista')
  end

  scenario '2: user can create a list if he is signed in' do
    #Arrange
    user = create(:user)

    #Act
    login_as(user)
    visit root_path
    click_on 'Nova Lista'
    fill_in 'Nome da lista', with: 'Churrasco de Aniversário'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Lista criada com sucesso!')
    expect(page).to have_css('h1', text: 'Churrasco de Aniversário')
  end
end