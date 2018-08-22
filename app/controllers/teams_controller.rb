class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :status]

  helper_method :sort_column, :sort_direction

  def index
    @teams = Team.order(sort_column + ' ' + sort_direction)
    @teams = @teams.filter_by_term(params[:term]) if params[:term].present?
    @teams = @teams.paginate(per_page: 50, page: params[:page])

    respond_to do |f|
      f.html { render :index }
      f.js { render :index, layout: false }
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to teams_path, notice: "Successfully created"
    else
      render partial: 'errors/errors', locals: { resource: @team }
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to teams_path, notice: "Successfully updated"
    else
      render partial: 'errors/errors', locals: { resource: @team }
    end
  end

  def status
    if @team.desactive?
      @team.active!
    else
      @team.desactive!
    end
    render :status, layout: false
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end


  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Team.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def team_params
    params.require(:team).permit(:name)
  end
end