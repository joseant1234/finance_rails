# INCOMES AND EXPENSES COULD BE IN ONE MODEL (TRANSACTION), HOWEVER I THINK IN THE FUTURE INCOMES AND EXPENSES WILL HAVE DIFFERENT LOGIC IN DRASTIC WAY
# ALSO, THERE WILL BE TOO MANY RECORDS IN DATABASES
class Income < ApplicationRecord

  include ActionView::Helpers::NumberHelper

  belongs_to :client
  belongs_to :country
  belongs_to :currency
  belongs_to :team, optional: true
  belongs_to :collaborator, optional: true

  enum state: [:pending, :paid, :overdued]
  enum source: [:invoice, :other]

  validates :description, :amount, :billing_at, :registered_at, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :invoice_copy, :invoice_number, :igv, presence: true, if: :invoice?
  validates :igv, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 0 }, if: :invoice?

  has_attached_file :invoice_copy, default_url: "/images/default.png"
  validates_attachment_content_type :invoice_copy, content_type: /\Aimage\/.*\z/

  has_attached_file :purchase_order, default_url: "/images/default.png"
  validates_attachment_content_type :purchase_order, content_type: /\Aimage\/.*\z/

  before_save :set_transaction_at
  after_initialize :set_defaults

  def self.registered_from(from_date)
    if from_date.present?
      where("incomes.registered_at >= ?", from_date.to_datetime)
    else
      where("incomes.registered_at >= ?", Date.today.to_datetime.beginning_of_month)
    end
  end

  def self.registered_to(to_date)
    if to_date.present?
      where("incomes.registered_at <= ?", to_date.to_datetime.end_of_day)
    else
      where("incomes.registered_at <= ?", Date.today.end_of_day.to_datetime)
    end
  end

  def self.billing_from(from_date)
    where("incomes.billing_at >= ?", from_date.to_datetime)
  end

  def self.billing_to(from_date)
    where("incomes.billing_at <= ?", from_date.to_datetime.end_of_day)
  end

  def self.filter_by_state(state)
    send(state)
  end

  def self.filter_by_source(source)
    send(source)
  end

  def self.filter_by_country(country)
    joins(:country).where('LOWER(countries.name) = ?',country.try(:downcase) || 'Peru'.downcase).distinct
  end

  def self.filter_by_currency(currency)
    where('incomes.currency_id = ?',currency)
  end

  def self.calculate_total_soles
    where(currency_id: Currency.find_by_code('PEN')).sum("incomes.amount")
  end

  def self.calculate_total_dollar
    where(currency_id: Currency.find_by_code('USD')).sum("incomes.amount")
  end

  def self.calculate_total_dollar_in_soles
    calculate_total_dollar * Parameter.rate_of_change.last.value.to_f || 0
  end

  def self.calculate_total_in_soles
    calculate_total_soles + calculate_total_dollar_in_soles
  end

  def amount_decimal
    number_with_precision(amount, :precision => 2) || 0
  end

  def calculate_igv_amount
    ((self.amount || 0) * ((self.igv || 0) / 100)).round(2)
  end

  def calculate_total
    ((self.amount || 0) + calculate_igv_amount).round(2)
  end

  private
  def set_transaction_at
    self.transaction_at = nil if self.overdued?
  end

  def set_defaults
    (self.igv ||=  Parameter.igv.last.value) if self.invoice?
    self.registered_at ||= Time.now
  end

end
