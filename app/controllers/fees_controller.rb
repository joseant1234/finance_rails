class FeesController < ApplicationController
  before_action :set_expense, only: [:index]
  before_action :set_fee, only: [:show, :edit, :update]

  def index
    @fees = @expense.fees.paginate(per_page: 30, page: params[:page])
  end

  def show
    if @fee.document.present?
      send_file @fee.document.path, filename: @fee.document.original_filename
    else
      render nothing: true, status: 204, notice: "Nothing to download"
    end
  end

  def edit
    render :edit, layout: false
  end

  def update
    @fee.is_paying = true
    if @fee.update(fee_params)
      render :update, layout: false
    else
      render partial: 'errors/errors', locals: { resource: @fee }
    end
  end

  private
  def set_expense
    @expense = Expense.find(params[:expense_id])
  end

  def set_fee
    @fee = Fee.find(params[:id])
  end

  def authorize_view
    redirect_to expenses_path if !@expense.pending?
  end

  def fee_params
    params.require(:fee).permit(:amount, :planned_payment_at, :transaction_at, :document)
  end
end