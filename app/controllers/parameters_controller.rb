class ParametersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parameter, only: [:edit,:update]

  def index
    @parameters = Parameter.all.paginate(per_page: 30, page: params[:page])
  end

  def edit
    render :edit, layout: false
  end

  def update
    if @parameter.update(parameter_params)
      render :update, layout: false
    else
      render partial: 'errors/errors', locals: { resource: @parameter }
    end
  end

  private
  def set_parameter
    @parameter = Parameter.find(params[:id])
  end

  def parameter_params
    params.require(:parameter).permit(:kind,:value)
  end
end