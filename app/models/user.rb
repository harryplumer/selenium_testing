class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :gender, :age
  validates_inclusion_of :gender, in: %w(Male Female Other)
  validates :age, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  has_many :bank_accounts, dependent: :destroy

  # Instance Method
  # Useage - current_user.is_old_enough?
  def is_old_enough?
    age > 16 ? true : false
  end

  # Class Methods - Also called scopes
  # Useage - index action to order all users by their age ASC
  # def index
  #   @users = User.all.by_age
  # end
  def self.by_age
    order(:age)
  end
end
