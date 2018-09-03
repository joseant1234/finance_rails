class Fee < ApplicationRecord

  include ActionView::Helpers::NumberHelper

  belongs_to :expense
  default_scope { order(id: :asc) }

  has_attached_file :document, styles: { medium: "400x600>"}
  validates_attachment_file_name :document, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

  validates :amount, :planned_payment_at, presence: true
  validates :transaction_at, presence: true, if: :is_paying

  after_update :update_status_of_expense, :update_cache_field_of_expense

  attr_accessor :is_paying

  def self.filter_by_paid
    where.not(transaction_at: nil, amount: nil)
  end

  def self.filter_by_not_paid
    where(transaction_at: nil).or(Fee.where(amount: nil))
  end

  def is_paid?
    self.transaction_at.present? && self.amount.present?
  end

  def is_not_paid?
    self.transaction_at.blank? || self.amount.blank?
  end

  def amount_decimal
    number_with_precision(amount, :precision => 2) || 0
  end

  private
  # last fee
  def update_status_of_expense
    if self.expense.fees.filter_by_paid.count == self.expense.fees.count
      self.expense.transaction_at = self.transaction_at
      self.expense.paid!
    end
  end

  def update_cache_field_of_expense
    self.expense.update(
      planned_payment_at: self.expense.fees.filter_by_not_paid.minimum(:planned_payment_at),
      remaining_amount: self.expense.amount - self.expense.fees.filter_by_paid.sum(:amount)
    )
  end

end
