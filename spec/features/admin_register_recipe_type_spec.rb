require 'rails_helper'

feature 'User register recipe type' do
  scenario 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Novo Tipo de Receita'
    fill_in 'Novo Tipo de Receita', with: 'Entrada'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Entrada')
    expect(page).to have_link('Voltar')
    expect(page).to have_content('Novo tipo de receita cadastrado com sucesso!')

  end
end