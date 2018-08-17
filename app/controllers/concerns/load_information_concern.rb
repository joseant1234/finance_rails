module LoadInformationConcern extend ActiveSupport::Concern

  def load_countries
   @countries = Country.order_by_name
  end

  def load_providers
    @providers = Provider.order_by_name
  end

end