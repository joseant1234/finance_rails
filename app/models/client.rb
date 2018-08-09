class Client < ApplicationRecord

  belongs_to :country
  has_many :operations

  enum status: [:active, :desactive]

  validates :name, :address, :phone, presence: true

  def self.filter_by_term(term)
    where("LOWER(clients.name) LIKE ?
      OR LOWER(clients.ruc) LIKE ?
      OR LOWER(clients.address) LIKE ?
      OR LOWER(clients.phone) LIKE ?",
      "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
      "%#{term.downcase}%")
    .group(:id)
  end

end
