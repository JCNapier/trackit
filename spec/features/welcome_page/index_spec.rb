require 'rails_helper'

RSpec.describe 'user welcome page' do
  it 'has a link to create a new user' do 
    visit root_path

    expect(page).to have_link('Create User')
    expect(page).to have_link('User Login')

    click_link 'Create User'

    expect(current_path).to eq(new_user_path)
  end

  it 'has a link to login an existing user' do 
    visit root_path

    expect(page).to have_link('Create User')
    expect(page).to have_link('User Login')

    click_link 'User Login'

    expect(current_path).to eq(new_session_path)
  end
end