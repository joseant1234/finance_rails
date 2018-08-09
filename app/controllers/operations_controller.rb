class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_operation, only: [:edit, :update]

  helper_method :sort_column, :sort_direction

  def index
    @operations = Operation.paginate(per_page: 2, page: params[:page])
  end

  def new
    @operation = Operation.new
  end

  def create
  end

  def edit
  end

  def update
  end

  private
  def set_operation
    @operation = Operation.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Operation.column_names.include?(params[:sort]) ? params[:sort] : "amount"
  end

  def operation_params
    params.require(:operation).permit(:provider_id, :client_id, :igv_amount, :total)
  end

end