require 'rails_helper'
require 'pry'

feature "Back Accounts New", js: true do 
  login_js
  before(:each) do
    visit new_bank_account_path
  end

  scenario "Shows current user on top" do
    expect(page).to have_content(@user.email)
  end 

  scenario "Renders form" do
    expect(page).to have_selector('.new_bank_account', count: 1)
  end 

  scenario "Link to all accounts is on Page" do
    expect(page).to have_selector('.all-accounts', count: 1) 
  end 

  scenario "Submits form" do
    fill_in('Institution', :with => 'Mountain America')
    fill_in('Description', :with => 'Slush fund')
    fill_in('Amount', :with => '1000')
    check('Active')
    click_button('Create Bank account')
    expect(@user.bank_accounts.count).to eq(1)
  end
end