class Client < ApplicationRecord

  include SortableConcern

  belongs_to :country
  has_many :expenses
  has_many :incomes

  enum status: [:active, :desactive]

  validates :name, :address, :phone, presence: true
  validates :name, :corporate_name, :address, :contact, length: { maximum: 50 }
  validates :ruc, length: { maximum: 11 }
  validates :phone, length: { maximum: 10 }

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
