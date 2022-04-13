require 'rails_helper'

RSpec.describe 'user new page' do
  describe 'user creation' do 
    context 'happy paths' do 
      it 'can create a new user' do 
        visit new_user_path
    
        fill_in :user_name, with: 'ClaudeCat'
        fill_in :email, with: 'ClaudeCat@alleycats.com'
        fill_in :password, with: 'meowmix123'
        fill_in :password_confirmation, with: 'meowmix123'
    
        click_button 'Create New User'
    
        expect(current_path).to eq(user_path(User.last))
        expect(page).to have_content(User.last.user_name)
      end
    end

    context 'sad paths' do 
      it 'flashes error when user_name is left blank' do 
        visit new_user_path
    
        fill_in :user_name, with: nil
        fill_in :email, with: 'ClaudeCat@alleycats.com'
        fill_in :password, with: 'meowmix123'
        fill_in :password_confirmation, with: 'meowmix123'
    
        click_button 'Create New User'
    
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("User name can't be blank")
      end

      it 'flashes error when email is left blank passed' do 
        visit new_user_path
    
        fill_in :user_name, with: "ClaudeCat"
        fill_in :email, with: nil
        fill_in :password, with: 'meowmix123'
        fill_in :password_confirmation, with: 'meowmix123'
    
        click_button 'Create New User'
    
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Email can't be blank")
      end

      it 'flashes error when password is left blank' do 
        visit new_user_path
    
        fill_in :user_name, with: "ClaudeCat"
        fill_in :email, with: 'ClaudeCat@alleycats.com'
        fill_in :password, with: nil
        fill_in :password_confirmation, with: 'meowmix123'
    
        click_button 'Create New User'
    
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Password digest can't be blank , Password is too short (minimum is 6 characters) , Password can't be blank")
      end

      it 'flashes error when password_confirmation is left blank' do 
        visit new_user_path
    
        fill_in :user_name, with: "ClaudeCat"
        fill_in :email, with: 'ClaudeCat@alleycats.com'
        fill_in :password, with: 'meowmix123'
        fill_in :password_confirmation, with: nil
    
        click_button 'Create New User'
    
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it 'flashes error when too short of password is passed' do 
        visit new_user_path
    
        fill_in :user_name, with: "ClaudeCat"
        fill_in :email, with: 'ClaudeCat@alleycats.com'
        fill_in :password, with: 'meo'
        fill_in :password_confirmation, with: 'meo'
    
        click_button 'Create New User'
    
        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Password is too short (minimum is 6 characters)")
      end
    end
  end

  describe 'user login' do 
    context 'happy paths' do 
      it 'can login an existing user' do 
        user = User.create!(
          user_name: 'ClaudeCat', 
          email: 'ClaudeCat@alleycats.com',
          password: 'meowmix123', 
          password_confirmation: 'meowmix123'
        )
    
        visit new_session_path
    
        fill_in :user_name, with: 'ClaudeCat'
        fill_in :password, with: 'meowmix123'
    
        click_button 'Login'
    
        expect(current_path).to eq(user_path(user))
        expect(page).to have_content("Welcome Back #{user.user_name}!")
      end
    end

    context 'sad paths' do 
      it 'flashes an error when user_name is left blank' do 
        user = User.create!(
          user_name: 'ClaudeCat', 
          email: 'ClaudeCat@alleycats.com',
          password: 'meowmix123', 
          password_confirmation: 'meowmix123'
        )
    
        visit new_session_path
    
        fill_in :user_name, with: nil
        fill_in :password, with: 'meowmix123'
    
        click_button 'Login'
    
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content("Email and/or Password is Invalid")
      end

      it 'flashes an error when password is left blank' do 
        user = User.create!(
          user_name: 'ClaudeCat', 
          email: 'ClaudeCat@alleycats.com',
          password: 'meowmix123', 
          password_confirmation: 'meowmix123'
        )
    
        visit new_session_path
    
        fill_in :user_name, with: 'ClaudeCat'
        fill_in :password, with: nil
    
        click_button 'Login'
    
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content("Email and/or Password is Invalid")
      end

      it 'flashes an error when user_name is incorrect' do 
        user = User.create!(
          user_name: 'ClaudeCat', 
          email: 'ClaudeCat@alleycats.com',
          password: 'meowmix123', 
          password_confirmation: 'meowmix123'
        )
    
        visit new_session_path
    
        fill_in :user_name, with: 'Cat'
        fill_in :password, with: 'meowmix123'
    
        click_button 'Login'
    
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content("Email and/or Password is Invalid")
      end

      it 'flashes an error when password is incorrect' do 
        user = User.create!(
          user_name: 'ClaudeCat', 
          email: 'ClaudeCat@alleycats.com',
          password: 'meowmix123', 
          password_confirmation: 'meowmix123'
        )
    
        visit new_session_path
    
        fill_in :user_name, with: 'ClaudeCat'
        fill_in :password, with: 'MeowMeowMeow'
    
        click_button 'Login'
    
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content("Email and/or Password is Invalid")
      end

      it 'flashes an error when user name and password is incorrect' do 
        user = User.create!(
          user_name: 'ClaudeCat', 
          email: 'ClaudeCat@alleycats.com',
          password: 'meowmix123', 
          password_confirmation: 'meowmix123'
        )
    
        visit new_session_path
    
        fill_in :user_name, with: 'ZelmaTheGreat'
        fill_in :password, with: 'woofwoofwoof'
    
        click_button 'Login'
    
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content("Email and/or Password is Invalid")
      end
    end
  end
end