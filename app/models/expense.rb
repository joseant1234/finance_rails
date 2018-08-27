class Expense < ApplicationRecord

  include ActionView::Helpers::NumberHelper

  belongs_to :provider
  belongs_to :country
  belongs_to :bank, optional: true
  belongs_to :currency
  belongs_to :team, optional: true
  belongs_to :category, optional: true
  belongs_to :collaborator, optional: true
  has_many :fees

  enum state: [:pending, :paid, :overdued]
  enum source: [:invoice, :direct]
  enum payment_type: [:transference, :realized, :upon_delivery]

  validates :description, :amount, presence: true
  validates :document_number, :planned_payment_at, presence: true, if: :invoice?
  validates :transaction_at, presence: true, if: :paid?
  validates :team, :issue_at, presence: true, if: :direct?

  has_attached_file :transaction_document, default_url: "/images/default.png"
  validates_attachment_content_type :transaction_document, content_type: /\Aimage\/.*\z/

  accepts_nested_attributes_for :fees, allow_destroy: true

  before_save :set_transaction_at

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

  def self.filter_by_source(source)
    send(source)
  end

  def self.filter_by_country(country)
    joins(:country).where('LOWER(countries.name) = ?',country.try(:downcase) || 'Peru'.downcase).distinct
  end

  def self.filter_by_bank(bank)
    where('expenses.bank_id = ?',bank).distinct
  end

  def self.filter_by_currency(currency)
    joins(:currency).where('currencies.id = ?',currency).distinct
  end

  def self.filter_by_category(category)
    joins(:category).where('categories.id = ?',category).distinct
  end

  def self.calculate_total_soles
    where(currency_id: Currency.find_by_code('PEN')).sum("expenses.amount")
  end

  def self.calculate_total_dollar
    where(currency_id: Currency.find_by_code('USD')).sum("expenses.amount")
  end

  def self.calculate_total_dollar_in_soles
    calculate_total_dollar * Parameter.rate_of_change.last.value.to_f || 0
  end

  def self.calculate_total_in_soles
    calculate_total_soles + calculate_total_dollar_in_soles
  end


  def amount_decimal
    number_with_precision(amount, precision: 2) || 0
  end

  def pay(amount, transaction_at, transaction_document)
    self.update({ amount: amount, transaction_at: transaction_at, transaction_document: transaction_document, state: 'paid' })
  end

  def save_with_category(category)
    self.category = Category.find_by_name(category)
    self.save
  end

  def update_with_category(params,category)
    self.category = Category.find_by_name(category)
    self.update(params)
  end

  private
  def set_transaction_at
    self.transaction_at = nil if self.overdued?
  end



end
