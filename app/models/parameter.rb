class Parameter < ApplicationRecord

  enum kind: [:rate_of_change,:igv]
end
