class Expense < ApplicationRecord
  belongs_to :provider
  belongs_to :client
  belongs_to :country

  enum state: [:pending, :paid, :cancelled]
  enum source: [:invoice, :direct]

end
