require 'rails_helper'

feature 'System can recognize factories' do
  scenario 'successfully' do
    #Arrange
    user = create(:user)

    #Act
    login_as(user)
    visit root_path

    #Assert
    expect(page).to have_content("Olá, #{user.email}!")
  end
end
