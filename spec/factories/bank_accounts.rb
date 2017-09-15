FactoryGirl.define do
  factory :bank_account do
    amount (1..5000).to_a.sample
    institution "Chase"
    description "My Personal Checking Account"
    user
  end
end
