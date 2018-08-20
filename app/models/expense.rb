class Expense < ApplicationRecord
  belongs_to :provider
  belongs_to :country
  belongs_to :bank, optional: true
  belongs_to :currency
  has_many :fees

  enum state: [:pending, :paid, :cancelled]
  enum source: [:invoice, :direct]
  enum payment_type: [:transference, :realized, :upon_delivery]
  
  validates :description, :amount, :planned_payment_at, presence: true
  validates :document_number, presence: true, if: :invoice?

  has_attached_file :transaction_document, default_url: "/images/default.png"
  validates_attachment_content_type :transaction_document, content_type: /\Aimage\/.*\z/

  accepts_nested_attributes_for :fees, allow_destroy: true

  def self.from_date(from_date)
    if from_date.present?
      where("expenses.created_at >= ?", from_date.to_datetime)
    else
      where("expenses.created_at >= ?", Date.today.to_datetime.beginning_of_month)
    end
  end

  def self.to_date(to_date)
    if to_date.present?
      where("expenses.created_at <= ?", to_date.to_datetime.end_of_day)
    else
      where("expenses.created_at <= ?", Date.today.end_of_day.to_datetime)
    end
  end

  def self.filter_by_state(state)
    send(state)
  end

  def self.filter_by_payment_type(payment_type)
    send(payment_type)
  end

  def self.filter_by_country(country)
    joins(:country).where('LOWER(countries.name) = ?',country.try(:downcase) || 'Peru'.downcase).distinct
  end

  def self.filter_by_bank(bank)
    where('expenses.bank_id = ?',bank).distinct
  end

  def self.filter_by_currency(currency)
    joins(:currencies).where('LOWER(currencies.id) = ?',currency).distinct
  end


end
