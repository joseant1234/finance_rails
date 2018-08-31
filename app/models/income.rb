class Income < ApplicationRecord

  include ActionView::Helpers::NumberHelper

  belongs_to :client
  belongs_to :country
  belongs_to :currency
  belongs_to :team, optional: true
  belongs_to :collaborator, optional: true

  enum state: [:pending, :paid, :overdued]
  enum source: [:invoice, :direct]

  validates :description, :amount, :billing_at, :expiration_at, presence: true
  validates :invoice_copy, :invoice_number, presence: true, if: :invoice?

  has_attached_file :invoice_copy, default_url: "/images/default.png"
  validates_attachment_content_type :invoice_copy, content_type: /\Aimage\/.*\z/

  has_attached_file :purchase_order, default_url: "/images/default.png"
  validates_attachment_content_type :purchase_order, content_type: /\Aimage\/.*\z/

  before_save :set_transaction_at


  def self.from_date(from_date)
    if from_date.present?
      where("incomes.created_at >= ?", from_date.to_datetime)
    else
      where("incomes.created_at >= ?", Date.today.to_datetime.beginning_of_month)
    end
  end

  def self.to_date(to_date)
    if to_date.present?
      where("incomes.created_at <= ?", to_date.to_datetime.end_of_day)
    else
      where("incomes.created_at <= ?", Date.today.end_of_day.to_datetime)
    end
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

  private
  def set_transaction_at
    self.transaction_at = nil if self.overdued?
  end


end
