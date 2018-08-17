class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:edit, :update]

  helper_method :sort_column, :sort_direction

  def index
    @expenses = Expense.paginate(per_page: 2, page: params[:page])
  end

  def new
    @expense = Expense.new
    load_countries
    load_providers
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: 'Successfully created'
    else
      render partial: 'errors/errors', locals: { resource: @expense }
    end
  end

  def edit
  end

  def update
  end

  def provider_information
    @provider = Provider.find_by_id(params[:id])
    render :provider_information, layout: false
  end

  private
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Expense.column_names.include?(params[:sort]) ? params[:sort] : "amount"
  end

  def expense_params
    params.require(:expense).permit(:provider_id, :country_id, :document_number,
                                    :source, :description, :amount, :igv_amount,
                                    :billing_at)
  end

end