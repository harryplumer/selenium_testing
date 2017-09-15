class BankAccount < ApplicationRecord
  # Association
  belongs_to :user
  # you need a text column
  serialize :ledger, Array

  # Validations
  validates_presence_of :amount, :institution, :active

  # Callbacks
  before_create :initialize_ledger
  before_update :update_ledger

  private
    def initialize_ledger
      self.ledger << { ledger_change: Time.now, previous_amount: 0, new_amount: self.amount }
    end

    def update_ledger
      if self.changes[:amount]
        self.ledger << { legder_change: Time.now, previous_amount: self.changes[:amount].first, new_amount: self.amount }
      end
    end
end
