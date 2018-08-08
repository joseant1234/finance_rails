class ProvidersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_provider, only: [:show, :edit, :update, :status]

  helper_method :sort_column, :sort_direction

  def index
    @providers = Provider.includes(:country).order(sort_column + ' ' + sort_direction)
    @providers = @providers.paginate(per_page: 2, page: params[:page])
  end

  def show
  end

  def new
    @provider = Provider.new
    load_countries
  end

  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      redirect_to providers_path, notice: "Successfully created"
    else
      render partial: 'errors/errors', locals: { resource: @provider }
    end
  end

  def edit
    load_countries
  end

  def update
    if @provider.update(provider_params)
      redirect_to providers_path, notice: "Successfully updated"
    else
      render partial: 'errors/errors', locals: { resource: @provider }
    end
  end

  def status
    if @provider.desactive?
      @provider.active!
    else
      @provider.desactive!
    end
    render :status, layout: false
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end


  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def sort_column
    Provider.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def provider_params
    params.require(:provider).permit(:name, :ruc, :address, :phone, :contact, :country_id)
  end
end