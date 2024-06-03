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
      password: '111111',
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
    },
    {
      last_name: 'Bergamo',
      first_name: 'Abramo',
      canonical_name: 'abramo5',
      public_name: 'ramo',
      position: 1,
      email: 'abramo@example.com',
      password: '555555'
    },
    {
      last_name: 'Arditi',
      first_name: 'Brunello',
      canonical_name: 'Brunello6',
      public_name: 'Brunello',
      position: 1,
      email: 'Brunello@example.com',
      password: '666666'
    },
    {
      last_name: 'Bellet',
      first_name: 'Ambre',
      canonical_name: 'ambre7',
      public_name: 'ambre',
      position: 0,
      email: 'abmre@example.com',
      password: '777777'
    },
    {
      last_name: 'Cazal',
      first_name: 'Char',
      canonical_name: 'char8',
      public_name: 'chacha',
      position: 1,
      email: 'char@example.com',
      password: '888888'
    },
    {
      last_name: 'Bueno',
      first_name: 'Amado',
      canonical_name: 'amado9',
      public_name: 'ama',
      position: 0,
      email: 'amado@example.com',
      password: '999999'
    },
    {
      last_name: 'Correa',
      first_name: 'Jacobo',
      canonical_name: 'jacob10',
      public_name: 'Jacob',
      position: 1,
      email: 'jacob@example.com',
      password: '101010'
    },
    {
      last_name: 'Lavalle',
      first_name: 'Juana',
      canonical_name: 'juana11',
      public_name: 'Juana',
      position: 0,
      email: 'juana@example.com',
      password: '111111'
    },
    {
      last_name: 'Asimov',
      first_name: 'Faina',
      canonical_name: 'fiana12',
      public_name: 'Fiana',
      position: 0,
      email: 'fiana@example.com',
      password: '121212'
    },
    {
      last_name: 'Bykovsky',
      first_name: 'Filipp',
      canonical_name: 'filipp13',
      public_name: 'filipp',
      position: 1,
      email: 'filipp@example.com',
      password: '131313'
    },
    {
      last_name: 'Banach',
      first_name: 'Celina',
      canonical_name: 'CELINA14',
      public_name: 'Celina',
      position: 0,
      email: 'celina@example.com',
      password: '141414'
    },
    {
      last_name: 'Dudek',
      first_name: 'Bolek',
      canonical_name: 'BOLEK15',
      public_name: 'Bolek',
      position: 0,
      email: 'bolek@example.com',
      password: '151515'
    },
    {
      last_name: '伊藤',
      first_name: '葵',
      canonical_name: 'aoi16',
      public_name: 'aoi',
      position: 2,
      email: 'aoi@example.com',
      password: '161616'
    },
    {
      last_name: '渡部',
      first_name: '暖',
      canonical_name: 'dan17',
      public_name: 'dan',
      position: 0,
      email: 'dan@example.com',
      password: '171717'
    },
    {
      last_name: '山本',
      first_name: '律',
      canonical_name: 'ritsu18',
      public_name: 'ritsu',
      position: 0,
      email: 'ritsu@example.com',
      password: '181818'
    },
    {
      last_name: '鈴木',
      first_name: '悠馬',
      canonical_name: 'yuma19',
      public_name: 'ゆうま',
      position: 0,
      email: 'yuma@example.com',
      password: '191919'
    },
    {
      last_name: '川口',
      first_name: '優香',
      canonical_name: 'yuka20',
      public_name: 'ゆい',
      position: 0,
      email: 'yuka@example.com',
      password: '202020'
    },
    {
      last_name: '木村',
      first_name: '小春',
      canonical_name: 'koharu21',
      public_name: '小春',
      position: 0,
      email: 'koharu@example.com',
      password: '212121'
    },
    {
      last_name: '井上',
      first_name: '笑美',
      canonical_name: 'ema22',
      public_name: 'ema',
      position: 0,
      email: 'ema@example.com',
      password: '222222'
    },
    {
      last_name: '池田',
      first_name: '紗奈',
      canonical_name: 'sana23',
      public_name: 'さな',
      position: 0,
      email: 'sana@example.com',
      password: '232323'
    },
    {
      last_name: '林',
      first_name: '美桜',
      canonical_name: 'mIo24',
      public_name: 'mio',
      position: 0,
      email: 'mio@example.com',
      password: '242424'
    }
  ]
)