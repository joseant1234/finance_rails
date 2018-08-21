class Income < ApplicationRecord

  include ActionView::Helpers::NumberHelper

  belongs_to :client
  belongs_to :country
  belongs_to :currency

  enum state: [:pending, :paid, :cancelled]
  enum source: [:invoice, :direct]

  validates :description, :amount, :billing_at, presence: true
  validates :invoice_copy, :purchase_order, :invoice_number,
            :purchase_order_number, presence: true, if: :invoice?

  has_attached_file :invoice_copy, default_url: "/images/default.png"
  validates_attachment_content_type :invoice_copy, content_type: /\Aimage\/.*\z/

  has_attached_file :purchase_order, default_url: "/images/default.png"
  validates_attachment_content_type :purchase_order, content_type: /\Aimage\/.*\z/


end
