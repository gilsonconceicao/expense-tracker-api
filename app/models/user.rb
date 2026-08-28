class User < ApplicationRecord
  has_secure_password

  has_many :transactions
  has_one :address

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :transactions

  validates :name, presence: { message: "is required" }
  validates :email_address, presence: { message: "is required" }
end
