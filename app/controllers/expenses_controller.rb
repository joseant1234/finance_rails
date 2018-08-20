class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:edit, :update]

  helper_method :sort_column, :sort_direction

  def index
    if !request.xhr?
      load_countries_with_expense
      load_banks
      load_currencies
    end

    @expenses = Expense.includes(:provider)
    @expenses = @expenses.from_date(params[:from_date]).to_date(params[:to_date]).filter_by_country(params[:country])
    @expenses = @expenses.filter_by_currency(params[:currency]) unless params[:currency].blank?
    @expenses = @expenses.filter_by_state(params[:state]) unless params[:state].blank?
    @expenses = @expenses.filter_by_bank(params[:bank]) unless params[:bank].blank?
    @expenses = @expenses.filter_by_payment_type(params[:payment_type]) unless params[:payment_type].blank?
    @expenses = @expenses.paginate(per_page: 2, page: params[:page])
    
    respond_to do |f|
      f.html { render :index }
      f.js { render :index, layout: false }
    end

  end

  def new
    @expense = Expense.new
    load_countries
    load_providers
    load_banks
    load_currencies
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: 'Successfully created'
    else
      load_countries
      load_providers
      load_banks
      load_currencies
      render :new
    end
  end

  def edit
    load_countries
    load_providers
    load_banks
    load_currencies
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: 'Successfully updated'
    else
      load_countries
      load_providers
      load_banks
      load_currencies
      render :edit
    end
  end

  def provider_information
    @provider = Provider.find_by_id(params[:provider_id])
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
                                    :source, :description, :currency_id, :amount,
                                    :planned_payment_at, :with_fee, :payment_type,
                                    :account_number, :cci, :contact_email,
                                    :place_of_delivery, :delivery_at, :bank_id,
                                    fees_attributes: [:id, :amount, :planned_payment_at, :_destroy])
  end

end