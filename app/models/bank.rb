class Bank < ApplicationRecord

  include SortableConcern

  has_many :expenses
end
