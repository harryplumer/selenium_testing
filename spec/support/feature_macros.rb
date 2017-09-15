module FeatureMacros
  def login_js
    before(:each) do
      @user = FactoryGirl.create(:user)
      login_as(@user, scope: :user)
    end
  end
end