class Team < ApplicationRecord

  include SortableConcern

  has_many :collaborators

  enum status: [:active, :desactive]

  validates :name, presence: true
  validates :name, length: { maximum: 50 }

  def self.filter_by_term(term)
    where("LOWER(teams.name) LIKE ?","%#{term.downcase}%").group(:id)
  end
end
