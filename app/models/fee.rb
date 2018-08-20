class Fee < ApplicationRecord
  belongs_to :expense

  validates :amount, :planned_payment_at, presence: true
end
