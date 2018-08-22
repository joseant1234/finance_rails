class CollaboratorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:index, :new, :create]
  before_action :set_collaborator, only: [:show, :edit, :update, :status]

  helper_method :sort_column, :sort_direction

  def index
    @collaborators = @team.collaborators.order(sort_column + ' ' + sort_direction)
    @collaborators = @collaborators.filter_by_term(params[:term]) if params[:term].present?
    @collaborators = @collaborators.paginate(per_page: 50, page: params[:page])
    respond_to do |f|
      f.html { render :index }
      f.js { render :index, layout: false }
    end
  end

  def show
  end

  def new
    @collaborator = @team.collaborators.new
  end

  def create
    @collaborator = @team.collaborators.new(collaborator_params)

    if @collaborator.save
      redirect_to team_collaborators_path(@collaborator.team), notice: "Successfully created"
    else
      render partial: 'errors/errors', locals: { resource: @collaborator }
    end
  end

  def edit
  end

  def update
    if @collaborator.update(collaborator_params)
      redirect_to team_collaborators_path(@collaborator.team), notice: "Successfully updated"
    else
      render partial: 'errors/errors', locals: { resource: @collaborator }
    end
  end

  def status
    if @collaborator.desactive?
      @collaborator.active!
    else
      @collaborator.desactive!
    end
    render :status, layout: false
  end

  private
  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end


  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Collaborator.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def collaborator_params
    params.require(:collaborator).permit(:name, :last_name, :address, :phone, :email, :photo)
  end
end