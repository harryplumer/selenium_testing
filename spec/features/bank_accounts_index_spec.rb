require 'rails_helper'
require 'pry'

feature "Bank Accounts Index", js: true do 
  login_js
  
  context "with bank accounts" do
    before(:each) do
      @account_count = 5
      FactoryGirl.create_list(:bank_account, @account_count, user: @user)
      visit bank_accounts_path
    end
    
    scenario "shows each bank account" do
      expect(all('.bank-account').count).to eq(@account_count)
      @user.bank_accounts.each do |account|
        expect(page).to have_content (account.institution)
        expect(page).to have_content (account.description)
      end
    end 

    scenario "deletes a bank account" do 
      accept_confirm do 
        all('.delete-account').first.click
      end 
      expect(page).to have_selector('.bank-account', count: @account_count -1)
    end 

    scenario "does not delete a bank account if not confirmed" do
      dismiss_confirm do 
        all('.delete-account').first.click
      end 
      expect(page).to have_selector('.bank-account', count: @account_count)
    end 

    scenario "link to show path is on page" do
      expect(page).to have_selector('.show-account', count: @account_count) 
    end 
  end 

  context "without bank accounts" do
    before(:each) do
      visit bank_accounts_path 
    end  

    scenario "correct header content" do 
      expect(page).to have_content("All My Monies")
    end

    scenario "correct no bank account message" do
      expect(page).to have_content("No Bank Accounts! Go get that paper!")
    end     
  end 

end