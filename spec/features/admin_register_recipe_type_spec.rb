require 'rails_helper'

feature 'User register recipe type' do
  scenario 'successfully' do
    # Arrange
    #user = User.create!(email: 'email@email.com', password: '123456')
    user = create(:user)

    #Act
    login_as(user)
    visit root_path
    # click_on 'Entrar'
    # within('form#new_user') do
    #   fill_in 'Email', with: user.email
    #   fill_in 'Senha', with: '123456'
    #   click_on 'Entrar'
    # end
    click_on 'Novo Tipo de Receita'
    fill_in 'Novo Tipo de Receita', with: 'Entrada'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Entrada')
    expect(page).to have_link('Voltar')
    expect(page).to have_content('Novo tipo de receita cadastrado com sucesso!')

  end

  scenario 'blank recipe type register can not be registered' do
    user = User.create!(email: 'email@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Novo Tipo de Receita'
    fill_in 'Novo Tipo de Receita', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Tipo de receita não cadastrado!')
    expect(page).to have_content('Campo obrigatório!')

  end

  scenario 'duplicate recipe type register can not be registered' do
    # Arrange
    user = User.create!(email: 'email@email.com', password: '123456')

    #Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Novo Tipo de Receita'
    fill_in 'Novo Tipo de Receita', with: 'Massas'
    click_on 'Enviar'
    click_on 'Voltar'
    click_on 'Novo Tipo de Receita'
    fill_in 'Novo Tipo de Receita', with: 'Massas'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Tipo de receita não cadastrado!')
    expect(page).to have_content('Campo duplicado!')

  end
end