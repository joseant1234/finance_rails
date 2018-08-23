class Collaborator < ApplicationRecord

  include SortableConcern

  belongs_to :team

  enum status: [:active, :desactive]

  validates :name, :last_name, presence: true
  validates :name, :last_name, :address, :email, length: { maximum: 50 }
  validates :phone, length: { maximum: 50 }
  validates_email_format_of :email, allow_blank: true

  has_attached_file :photo, default_url: "/images/default.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def self.filter_by_term(term)
    where("LOWER(collaborators.name) LIKE ?
      OR LOWER(collaborators.last_name) LIKE ?
      OR LOWER(collaborators.address) LIKE ?
      OR LOWER(collaborators.phone) LIKE ?
      OR LOWER(collaborators.email) LIKE ?",
      "%#{term.downcase}%", "%#{term.downcase}%", "%#{term.downcase}%",
      "%#{term.downcase}%","%#{term.downcase}%").group(:id)
  end

  def self.by_team(team)
    where(team_id: team)
  end

  def display_full_name
    "#{self.name} #{self.last_name}"
  end
end
