require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  # spec/support/controller_macros.rb
  login_user

  let(:valid_attributes) {
    { institution: 'Chase', amount: 200, active: true }
  }

  let(:invalid_attributes) {
    { institution: '' , amount: 200, active: true }
  }

  describe "GET #index" do
    it "returns http success" do
      FactoryGirl.create(:bank_account, user: @user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      bank_account = FactoryGirl.create(:bank_account, user: @user)
      get :show, params: { id: bank_account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      bank_account = FactoryGirl.create(:bank_account, user: @user)
      get :edit, params: { id: bank_account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new bank account' do
      # expect {
      #   post :create, params: { bank_account: valid_attributes }
      # }.to change(BankAccount, :count).by(1)

      post :create, params: { bank_account:  {institution: 'AFCU', amount: 300, active: true } }
      expect(@user.bank_accounts.count).to eq(1)
    end

    it 'does not create a new bank account with invalid params' do
      # post :create, params: { bank_account:  {institution: '', amount: 300, active: true } }
      post :create, params: { bank_account: invalid_attributes }
      expect(@user.bank_accounts.count).to eq(0)
    end
  end

  describe 'PUT / PATCH #update' do
    # def new_attributes
    #   { institution: 'Wells Fargo' }
    # end
    let(:new_attributes) {
      { institution: 'Wells Fargo' }
    }

    before(:each) do
      @bank_account = FactoryGirl.create(:bank_account, user: @user)
    end

    it 'updates the bank account with valid attributes' do
      put :update, params: { id: @bank_account.id, bank_account: new_attributes }
      # Stale variable situation - only time need to reload is in update
      @bank_account.reload
      expect(@bank_account.institution).to eq(new_attributes[:institution])
    end

    it 'does not update the bank account with invalid attributes' do
      put :update, params: { id: @bank_account.id, bank_account: invalid_attributes }
      @bank_account.reload
      expect(@bank_account.institution).to_not eq(invalid_attributes[:institution])
    end
  end

  describe 'DELETE #destroy' do
    
  end

end
