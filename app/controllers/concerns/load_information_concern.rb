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
    @countries = Country.where(id: Expense.select(:country_id ) )
  end



end