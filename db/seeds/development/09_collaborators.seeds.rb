collaborators = [
  {name: 'Name 1', last_name: 'Last name 1', team: Team.first },
  {name: 'Name 2', last_name: 'Last name 2', team: Team.second },
  {name: 'Name 3', last_name: 'Last name 3', team: Team.first },
  {name: 'Name 4', last_name: 'Last name 4', team: Team.first },
  {name: 'Name 5', last_name: 'Last name 5', team: Team.last },
  {name: 'Name 6', last_name: 'Last name 6', team: Team.second },
  {name: 'Name 7', last_name: 'Last name 7', team: Team.last },
  {name: 'Name 7', last_name: 'Last name 8', team: Team.last },
  {name: 'Name 7', last_name: 'Last name 9', team: Team.last }
]

Collaborator.create!(collaborators)