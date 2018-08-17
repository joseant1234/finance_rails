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
  end

  def create
  end

  def edit
  end

  def update
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

  def operation_params
    params.require(:expense).permit(:provider_id, :client_id, :igv_amount, :total)
  end

end