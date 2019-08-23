require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    #Arrange
    user = User.create!(email: 'email@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    #Assert
    expect(page).to have_content("Olá, #{user.email}!")

  end
end