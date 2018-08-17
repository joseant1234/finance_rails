providers = [
  {name: 'Provider 1', ruc: '12345678912', address: 'Address 1', phone: '1234567', country: Country.find_by_name('Peru')},
  {name: 'Provider 2', ruc: '12345678912', address: 'Address 2', phone: '1234567', country: Country.find_by_name('Peru')},
  {name: 'Provider 3', address: 'Address 3', phone: '1234567', country: Country.find_by_name('United States')},
  {name: 'Provider 4', address: 'Address 4', phone: '1234567', country: Country.find_by_name('Mexico')},
]

Provider.create!(providers)