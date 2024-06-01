# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin.com',
  password: 'adminadmin'
)

User.create!(
  [
    {
      last_name: '田中',
      first_name: '花子',
      canonical_name: 'Hanako1',
      public_name: 'はな',
      position: 2,
      email: 'hanako@example.com',
      password: '111111'
    },
    {
      last_name: '青木',
      first_name: '優子',
      canonical_name: 'Yuko2',
      public_name: 'ゆう',
      position: 2,
      email: 'yuko@example.com',
      password: '222222'
    },
    {
      last_name: 'Smith',
      first_name: 'James',
      canonical_name: 'james3',
      public_name: 'jam',
      position: 0,
      email: 'james@example.com',
      password: '333333'
    },
    {
      last_name: 'Johnson',
      first_name: 'Henry',
      canonical_name: 'henry4',
      public_name: 'hen',
      position: 1,
      email: 'henry@example.com',
      password: '444444'
    }
  ]
)