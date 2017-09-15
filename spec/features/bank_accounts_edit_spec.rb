require 'rails_helper'
require 'pry'

feature "Back Accounts Edit", js: true do 
  login_js
  before(:each) do
    @account = FactoryGirl.create(:bank_account, user: @user)    
    visit edit_bank_account_path(@account.id)
  end

  scenario "Shows current institution on top" do
    expect(page).to have_content(@account.institution)
  end 

  scenario "Renders form" do
    expect(page).to have_selector('.edit_bank_account', count: 1)
  end 

  scenario "Link to all accounts is on Page" do
    expect(page).to have_selector('.all-accounts', count: 1) 
  end 

  scenario "Updates record" do
    fill_in('Description', :with => 'Slush fund')
    click_button('Update Bank account')
    @account.reload
    expect(@user.bank_accounts.first.description).to eq("Slush fund")
  end
end