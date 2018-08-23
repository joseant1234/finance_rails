module LoadInformationConcern extend ActiveSupport::Concern

  def load_countries
   @countries = Country.order_by_name
  end

  def load_providers
    @providers = Provider.order_by_name
  end

  def load_banks
  	@banks = Bank.order_by_name
  end

  def load_currencies
  	@currencies = Currency.order_by_name
  end

  def load_countries_with_expense
    @countries = Country.where(id: Expense.select(:country_id ) ).or(Country.where(name: 'Peru')).order_by_name
  end

  def load_clients
    @clients = Client.order_by_name
  end

  def load_countries_with_income
    @countries = Country.where(id: Income.select(:country_id) ).or(Country.where(name: 'Peru')).order_by_name
  end

  def load_teams
    @teams = Team.order_by_name
  end

  def load_collaborators(team_id = nil)
    if team_id.blank?
      @collaborators = Collaborator.order_by_name
    else
      @collaborators = Collaborator.by_team(team_id).order_by_name
    end
  end


end