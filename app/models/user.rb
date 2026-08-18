class User < ApplicationRecord
  has_many :transactions
  has_one :address

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :transactions
end
