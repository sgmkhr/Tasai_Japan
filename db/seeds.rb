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

# 以下、ユーザーデータ
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
      password: '161616',
      introduction: '福岡生まれ福岡育ちです！福岡の魅力を伝えたいです！'
    },
    {
      last_name: '渡部',
      first_name: '暖',
      canonical_name: 'dan17',
      public_name: 'dan',
      position: 0,
      email: 'dan@example.com',
      password: '171717',
      introduction: '東京に長く住んでいます。東京のおすすめを発信します。'
    },
    {
      last_name: '山本',
      first_name: '律',
      canonical_name: 'ritsu18',
      public_name: 'ritsu',
      position: 0,
      email: 'ritsu@example.com',
      password: '181818',
      introduction: '岐阜生まれです。岐阜のおすすめスポットを投稿します。'
    },
    {
      last_name: '鈴木',
      first_name: '悠馬',
      canonical_name: 'yuma19',
      public_name: 'ゆうま',
      position: 0,
      email: 'yuma@example.com',
      password: '191919',
      introduction: '旅行が趣味です。日本国内で行って良かったところをお伝えしていきたいです！'

    },
    {
      last_name: '川口',
      first_name: '優香',
      canonical_name: 'yuka20',
      public_name: 'ゆい',
      position: 0,
      email: 'yuka@example.com',
      password: '202020',
      introduction: '千葉県在住です。千葉にもいろんなおすすめスポットあるので、紹介していきたいと思います。'
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

# 以下、投稿データ
# 福岡に馴染み深いサンプルユーザー
User.find_by(canonical_name: 'aoi16').posts.create!(
  [
    {
      title: '糸島の芥屋',
      caption: '福岡のドライブスポットといえば！',
      body: 'この前はドライブではなく、遊覧船に乗って鍾乳洞を覗きにいけるアクティビティに参加してきました。',
      prefecture: 7,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/fukuoka_itoshima.jpeg")),filename: 'fukuoka_itoshima.jpeg')
    },
    {
      title: '明太子のお重',
      caption: '博多に来たら必ず行ってほしい',
      body: '明太子好きにはたまらない！重厚な雰囲気だけどカジュアルにランチで楽しめる。',
      prefecture: 7,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/fukuoka_mentaizyu.jpeg")),filename: 'fukuoka_mentaizyu.jpeg')
    },
    {
      title: '柳川',
      caption: 'うなぎも有名な場所',
      body: '福岡市からは少し離れていますが、美味しい鰻重と穏やかな川下りが楽しめますよ。',
      prefecture: 7,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/fukuoka_yanagawa.jpeg")),filename: 'fukuoka_yanagawa.jpeg')
    }
  ]
)

# 東京に馴染み深いサンプルユーザー
User.find_by(canonical_name: 'dan17').posts.create!(
  [
    {
      title: '竜王スキー場',
      caption: '関東のスキー場といえばここ！',
      body: '関東に住まいの方に人気のスキー場。上の方に登ると、素敵な景色と共にビールも飲めちゃいます！',
      prefecture: 20,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/nagano_ryuo.jpeg")),filename: 'nagano_ryuo.jpeg')
    },
    {
      title: '秩父',
      caption: '東京から日帰りドライブにおすすめ',
      body: '秩父では荒川のライン下りが楽しいですよ！ランチはここがお気に入り。新鮮なジビエを岩の上で焼いて、きのこもたっぷり、自然の中で味わえる贅沢ランチです！',
      prefecture: 11,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/saitama_chichibu.jpg")),filename: 'saitama_chichibu.jpg')
    },
    {
      title: '浅草寺',
      caption: '日本の象徴的な観光スポット',
      body: '浅草寺の雷門が有名ですが、奥に進んだ場所から見えるこの眺めもおすすめです。夜は空いているので写真も撮りやすいですよ。',
      prefecture: 13,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/tokyo_asakusa.jpeg")),filename: 'tokyo_asakusa.jpeg')
    },
    {
      title: '渋谷スカイ',
      caption: '渋谷にできた高層商業施設の屋上！',
      body: '入場料は少しお高めですが、ここからの展望は本当に最高！芝生があるのでゆっくりできますよ。',
      prefecture: 13,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/tokyo_shibuya.jpg")),filename: 'tokyo_shibuya.jpg')
    }
  ]
)

# 岐阜に馴染み深いサンプルユーザー
User.find_by(canonical_name: 'ritsu18').posts.create!(
  [
    {
      title: '青川',
      caption: '付知川の清流',
      body: '本当に今まで見た川の中で一番エメラルド色！心も癒されるので、自然が好きな人にはぜひ訪れていただきたい！',
      prefecture: 21,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/gifu_river.jpeg")),filename: 'gifu_river.jpeg')
    },
    {
      title: '白川郷',
      caption: 'ここでしか見れない景色',
      body: '観光地として日本人にとっては馴染み深いですが、海外から来た人はあまり知らないかも。感動すること間違いなし！',
      prefecture: 21,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/gifu_shirakawago.jpg")),filename: 'gifu_shirakawago.jpg')
    }
  ]
)

# 旅行好きのサンプルユーザー
User.find_by(canonical_name: 'yuma19').posts.create!(
  [
    {
      title: '神戸',
      caption: '県名よりもよく知られている場所',
      body: '程よく品もあるエリア。遊ぶスポットもたくさんある、栄えた場所です。住む場所としても人気があります！',
      prefecture: 28,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/hyogo_kobe.jpeg")),filename: 'hyogo_kobe.jpeg')
    },
    {
      title: '江ノ電',
      caption: 'ドライブも良し、電車旅も良し',
      body: '関東エリアに住まいの人々は定期的に足を運ぶような場所。気軽に海を眺めに行けます。',
      prefecture: 14,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kanagawa_enoden.jpg")),filename: 'kanagawa_enoden.jpg')
    },
    {
      title: '鴨川',
      caption: '京都の代表的な景色',
      body: '5月から夏にかけては川沿いに川床が出されることでも有名。ランクの高い飲食店も多く、鴨川を眺めながら贅沢な食事の時間を過ごせます。',
      prefecture: 26,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kyoto_kamogawa.jpeg")),filename: 'kyoto_kamogawa.jpeg')
    },
    {
      title: '京都で日本酒',
      caption: 'お酒好きにはたまりません！',
      body: '日本酒の飲み比べに加えて、京都では、おちょこも選べちゃうお店が多い！',
      prefecture: 26,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/kyoto_nihonsyu.jpg")),filename: 'kyoto_nihonsyu.jpg')
    }
  ]
)

# 千葉に馴染みの深いユーザー
User.find_by(canonical_name: 'yuka20').posts.create!(
  [
    {
      title: '東京ドイツ村',
      caption: '名前は東京だけど千葉にあるよ！',
      body: '年中平和な雰囲気が漂っているテーマパーク！でも、冬のイルミネーションの時期は一味違います！！規模が桁違いの、すばらしい景色が観れるので、ぜひこの冬訪れてみてください！',
      prefecture: 12,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/chiba_doitumura.jpeg")),filename: 'chiba_doitumura.jpeg')
    },
    {
      title: 'いすみ市',
      caption: '星を見るならここ',
      body: '田舎町ではありますが、グランピング施設が多く点在しており、喧騒から離れて自然の中で癒されたい時におすすめのスポットです。',
      prefecture: 12,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/chiba_isumi.jpg")),filename: 'chiba_isumi.jpg')
    }
  ]
)

# 日本生活中級者のユーザー
User.find_by(canonical_name: 'henry4').posts.create!(
  [
    {
      title: 'Tokyo Tower',
      caption: 'A beautiful tower',
      body: 'The color change on each day. You can see the tower in mostly red but sometimes other colors.',
      prefecture: 13,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/tokyo_tower.jpeg")),filename: 'tokyo_tower.jpeg')
    },
    {
      title: 'Kamosui',
      caption: 'Aquarium',
      body: 'I visited Yamagata and found this beautiful aquarium. It was amazing.',
      prefecture: 6,
      post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/yamagata_kamosui.jpeg")),filename: 'yamagata_kamosui.jpeg')
    }
  ]
)