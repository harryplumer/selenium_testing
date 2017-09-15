require 'rails_helper'
require 'action_view'
include ActionView::Helpers::NumberHelper

feature 'Bank Account Show', js: true do
  login_js

  before(:each) do
    @account = FactoryGirl.create(:bank_account, user: @user)
    visit bank_account_path(@account.id)
  end

  scenario 'shows information' do
    expect(page).to have_content(@account.institution)
    expect(page).to have_content(@account.description)
    expect(page).to have_content(number_to_currency(@account.amount))
    expect(page).to have_content('Ledger Transactions')
  end

  scenario 'back link is on the page' do
     expect(page).to have_selector('.back')
   end

   scenario 'edit link is on the page' do
     expect(page).to have_selector('.edit')
   end

end