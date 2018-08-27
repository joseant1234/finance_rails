class Category < ApplicationRecord

  include SortableConcern

  has_many :expenses

  enum status: [:active, :desactive]

  validates :name, presence: true
  validates :name, length: { maximum: 50 }

  def self.filter_by_term(term)
    where("LOWER(categories.name) LIKE ?",
      "%#{term.downcase}%")
    .group(:id)
  end

end
