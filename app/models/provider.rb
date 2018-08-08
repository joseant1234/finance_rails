class Provider < ApplicationRecord

  belongs_to :country

  enum status: [:active, :desactive]

  validates :name, :address, :phone, presence: true
end
