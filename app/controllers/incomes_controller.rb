class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :download]

  helper_method :sort_column, :sort_direction

  def index
    if !request.xhr?
      load_countries_with_income
      load_currencies
    end

    @incomes = Income.includes(:client)
    @incomes = @incomes.from_date(params[:from_date]).to_date(params[:to_date]).filter_by_country(params[:country])
    @incomes = @incomes.filter_by_currency(params[:currency]) unless params[:currency].blank?
    @incomes = @incomes.filter_by_state(params[:state]) unless params[:state].blank?
    @incomes = @incomes.paginate(per_page: 2, page: params[:page])

    respond_to do |f|
      f.html { render :index }
      f.js { render :index, layout: false }
    end

  end

  def new
    @income = Income.new
    load_countries
    load_clients
    load_currencies
  end

  def create
    @income = Income.new(income_params)
    if @income.save
      redirect_to incomes_path, notice: 'Successfully created'
    else
      load_countries
      load_clients
      load_currencies
      render :new
    end
  end

  def edit
    load_countries
    load_clients
    load_currencies
  end

  def update
    if @income.update(income_params)
      redirect_to incomes_path, notice: 'Successfully updated'
    else
      load_countries
      load_clients
      load_currencies
      render :edit
    end
  end

  def download
    begin
      if params[:document].present?
        send_file @income.send(params[:document]).path, filename: @income.send(params[:document]).original_filename
      else
        render nothing: true, status: 204, notice: "Nothing to download"
      end
    rescue StandardError => error
      render nothing: true, status: 204, notice: "Nothing to download"
    end
  end

  def client_information
    @client = Client.find_by_id(params[:client_id])
    render :client_information, layout: false
  end

  private
  def set_income
    @income = Income.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Income.column_names.include?(params[:sort]) ? params[:sort] : "amount"
  end

  def income_params
    params.require(:income).permit(:income_id, :country_id, :invoice_number, :client_id,
                                    :source, :description, :currency_id, :amount,
                                    :billing_at, :purchase_order, :purchase_order_number,
                                    :invoice_copy)
  end
end