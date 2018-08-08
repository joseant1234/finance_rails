module LoadInformationConcern extend ActiveSupport::Concern

  def load_countries
   @countries = Country.order_by_name
  end

end