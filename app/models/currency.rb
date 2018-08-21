class Currency < ApplicationRecord

  include SortableConcern

  has_many :expenses
  has_many :incomes

end
