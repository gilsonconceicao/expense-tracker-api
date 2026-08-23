class Transaction < ApplicationRecord
  belongs_to :user

  validates :description, presence: { message: "is required" }

  validates :purpose, presence: { message: "is required" }

  validates :amount, presence: { message: "is required" }

  validates :amount, numericality: {
    greater_than: 0,
    message: "must be greater than zero"
  }

  validate :date_at_cannot_be_in_the_future

  private

  def date_at_cannot_be_in_the_future
    if date_at.present? && date_at > Date.today
      errors.add(:date_at, "cannot be in the future")
    end
  end
end
