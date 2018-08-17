class Expense < ApplicationRecord
  belongs_to :provider
  belongs_to :country

  enum state: [:pending, :paid, :cancelled]
  enum source: [:invoice, :direct]


  validates :amount, presence: true
  validates :igv_amount, :document_number, presence: true, if: :invoice?

end
