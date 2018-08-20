class Country < ApplicationRecord

  include SortableConcern

  has_many :providers
  has_many :expenses

end
