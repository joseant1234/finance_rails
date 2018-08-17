class Provider < ApplicationRecord

  include SortableConcern

  belongs_to :country
  has_many :operations

  enum status: [:active, :desactive]

  validates :name, :address, :phone, presence: true

  def self.filter_by_term(term)
    where("LOWER(providers.name) LIKE ?
      OR LOWER(providers.ruc) LIKE ?
      OR LOWER(providers.address) LIKE ?
      OR LOWER(providers.phone) LIKE ?",
      "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
      "%#{term.downcase}%")
    .group(:id)
  end
end
