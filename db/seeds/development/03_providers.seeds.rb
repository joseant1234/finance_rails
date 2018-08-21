providers = [
  {name: 'Provider 1', ruc: '12345678912', address: 'Address 1', phone: '1234567', country: Country.find_by_name('Peru'), corporate_name: 'Coporate name 1'},
  {name: 'Provider 2', ruc: '12345678912', address: 'Address 2', phone: '1234567', country: Country.find_by_name('Peru'), corporate_name: 'Coporate name 2'},
  {name: 'Provider 3', address: 'Address 3', phone: '1234567', country: Country.find_by_name('United States'), corporate_name: 'Coporate name 3'},
  {name: 'Provider 4', address: 'Address 4', phone: '1234567', country: Country.find_by_name('Mexico'), corporate_name: 'Coporate name 4'},
]

Provider.create!(providers)