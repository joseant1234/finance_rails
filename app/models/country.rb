class Country < ApplicationRecord

  include SortableConcern

  has_many :providers

end
