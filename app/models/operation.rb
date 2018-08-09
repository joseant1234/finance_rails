class Operation < ApplicationRecord
  belongs_to :provider
  belongs_to :client
  belongs_to :country

  enum state: [:pending, :paid, :cancelled]
  enum kind: [:income, :expense]
  enum source: [:invoice, :direct]

end
