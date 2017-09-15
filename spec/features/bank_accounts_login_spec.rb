require 'rails_helper'
require 'pry'

feature "Login", js: true do 
  before(:each) do
    visit bank_accounts_path
  end

  context "user is not logged in" do 
    scenario "navbar renders" do 
      expect(page).to have_selector('.navbar')
    end
    scenario "redirects to login page" do
      expect(current_path).to eq(new_user_session_path)
    end
    scenario "user logs in and redirects to home page" do
      @user = FactoryGirl.create(:user)
      fill_in('Email', :with => @user.email)
      fill_in('Password', :with => @user.password)
      click_button('Log in')
      expect(current_path).to eq(bank_accounts_path)
    end
  end

  context "user is logged in" do 
    login_js
    scenario "navbar renders" do 
      expect(page).to have_selector('.navbar')
    end
    
    scenario "logout destroys session and redirects to login page" do 
      click_link('Logout')
      expect(current_path).to eq(new_user_session_path)
    end 
  end 

end