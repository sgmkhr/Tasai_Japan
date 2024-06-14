# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'seedの実行を開始'

# 管理者
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

# 以下、ユーザーデータ
hana = User.find_or_create_by!(email: 'hanako@example.com') do |user|
  user.last_name = '田中'
  user.first_name = '花子'
  user.canonical_name = 'Hanako1'
  user.public_name = 'はな'
  user.position = 2
  user.password = '111111'
end

yuko = User.find_or_create_by!(email: 'yuko@example.com') do |user|
  user.last_name = '青木'
  user.first_name = '優子'
  user.canonical_name = 'Yuko2'
  user.public_name = 'ゆう'
  user.position = 2
  user.password = '222222'
  user.introduction = 'どうぞよろしくお願いします！'
end

james = User.find_or_create_by!(email: 'james@example.com') do |user|
  user.last_name = 'Smith'
  user.first_name = 'James'
  user.canonical_name = 'james3'
  user.public_name = 'jam'
  user.position = 0
  user.password = '333333'
  user.introduction = '日本来たばかりです！'
end

henry = User.find_or_create_by!(email: 'henry@example.com') do |user|
  user.last_name = 'Johnson'
  user.first_name = 'Henry'
  user.canonical_name = 'henry4'
  user.public_name = 'hen'
  user.position = 1
  user.password = '444444'
end

abramo = User.find_or_create_by!(email: 'abramo@example.com') do |user|
  user.last_name = 'Bergamo'
  user.first_name = 'Abramo'
  user.canonical_name = 'abramo5'
  user.public_name = 'ramo'
  user.position = 1
  user.password = '555555'
end

brunello = User.find_or_create_by!(email: 'brunello@example.com') do |user|
  user.last_name = 'Arditi'
  user.first_name = 'Brunello'
  user.canonical_name = 'Brunello6'
  user.public_name = 'Brunello'
  user.position = 1
  user.password = '666666'
end

ambre = User.find_or_create_by!(email: 'abmre@example.com') do |user|
  user.last_name = 'Bellet'
  user.first_name = 'Ambre'
  user.canonical_name = 'ambre7'
  user.public_name = 'ambre'
  user.position = 0
  user.password = '777777'
end

char = User.find_or_create_by!(email: 'char@example.com') do |user|
  user.last_name = 'Cazal'
  user.first_name = 'Char'
  user.canonical_name = 'char8'
  user.public_name = 'chacha'
  user.position = 1
  user.password = '888888'
end

amado = User.find_or_create_by!(email: 'amado@example.com') do |user|
  user.last_name = 'Bueno'
  user.first_name = 'Amado'
  user.canonical_name = 'amado9'
  user.public_name = 'ama'
  user.position = 0
  user.password = '999999'
end

jacobo = User.find_or_create_by!(email: 'jacob@example.com') do |user|
  user.last_name = 'Correa'
  user.first_name = 'Jacobo'
  user.canonical_name = 'jacob10'
  user.public_name = 'Jacob'
  user.position = 1
  user.password = '101010'
end

juana = User.find_or_create_by!(email: 'juana@example.com') do |user|
  user.last_name = 'Lavalle'
  user.first_name = 'Juana'
  user.canonical_name = 'juana11'
  user.public_name = 'Juana'
  user.position = 0
  user.password = '111111'
end

faina = User.find_or_create_by!(email: 'fiana@example.com') do |user|
  user.last_name = 'Asimov'
  user.first_name = 'Faina'
  user.canonical_name = 'fiana12'
  user.public_name = 'Fiana'
  user.position = 0
  user.password = '121212'
end

filipp = User.find_or_create_by!(email: 'filipp@example.com') do |user|
  user.last_name = 'Bykovsky'
  user.first_name = 'Filipp'
  user.canonical_name = 'filipp13'
  user.public_name = 'filipp'
  user.position = 1
  user.password = '131313'
end

celina = User.find_or_create_by!(email: 'celina@example.com') do |user|
  user.last_name = 'Banach'
  user.first_name = 'Celina'
  user.canonical_name = 'CELINA14'
  user.public_name = 'Celina'
  user.position = 0
  user.password = '141414'
end

bolek = User.find_or_create_by!(email: 'bolek@example.com') do |user|
  user.last_name = 'Dudek'
  user.first_name = 'Bolek'
  user.canonical_name = 'BOLEK15'
  user.public_name = 'Bolek'
  user.position = 0
  user.password = '151515'
end

aoi = User.find_or_create_by!(email: 'aoi@example.com') do |user|
  user.last_name = '伊藤'
  user.first_name = '葵'
  user.canonical_name = 'aoi16'
  user.public_name = 'aoi'
  user.position = 2
  user.password = '161616'
  user.introduction = '福岡生まれ福岡育ちです！福岡の魅力を伝えたいです！'
end

dan = User.find_or_create_by!(email: 'dan@example.com') do |user|
  user.last_name = '渡部'
  user.first_name = '暖'
  user.canonical_name = 'dan17'
  user.public_name = 'dan'
  user.position = 0
  user.password = '171717'
  user.introduction = '東京に長く住んでいます。東京のおすすめを発信します。'
end

ritsu = User.find_or_create_by!(email: 'ritsu@example.com') do |user|
  user.last_name = '山本'
  user.first_name = '律'
  user.canonical_name = 'ritsu18'
  user.public_name = 'ritsu'
  user.position = 0
  user.password = '181818'
  user.introduction = '岐阜生まれです。岐阜のおすすめスポットを投稿します。'
end

yuma = User.find_or_create_by!(email: 'yuma@example.com') do |user|
  user.last_name = '鈴木'
  user.first_name = '悠馬'
  user.canonical_name = 'yuma19'
  user.public_name = 'ゆうま'
  user.position = 0
  user.password = '191919'
  user.introduction = '旅行が趣味です。日本国内で行って良かったところをお伝えしていきたいです！'
end

yuka = User.find_or_create_by!(email: 'yuka@example.com') do |user|
  user.last_name = '川口'
  user.first_name = '優香'
  user.canonical_name = 'yuka20'
  user.public_name = 'ゆい'
  user.position = 0
  user.password = '202020'
  user.introduction = '千葉県在住です。千葉にもいろんなおすすめスポットあるので、紹介していきたいと思います。'
end

koharu = User.find_or_create_by!(email: 'koharu@example.com') do |user|
  user.last_name = '木村'
  user.first_name = '小春'
  user.canonical_name = 'koharu21'
  user.public_name = '小春'
  user.position = 0
  user.password = '212121'
end

emi = User.find_or_create_by!(email: 'ema@example.com') do |user|
  user.last_name = '井上'
  user.first_name = '笑美'
  user.canonical_name = 'ema22'
  user.public_name = 'ema'
  user.position = 0
  user.password = '222222'
end

sana = User.find_or_create_by!(email: 'sana@example.com') do |user|
  user.last_name = '池田'
  user.first_name = '紗奈'
  user.canonical_name = 'sana23'
  user.public_name = 'さな'
  user.position = 0
  user.password = '232323'
end

mio = User.find_or_create_by!(email: 'mio@example.com') do |user|
  user.last_name = '林'
  user.first_name = '美桜'
  user.canonical_name = 'mIo24'
  user.public_name = 'mio'
  user.position = 0
  user.password = '242424'
end


# 以下、投稿データ
post_drive = Post.find_or_create_by!(title: '糸島の芥屋') do |po|
  po.caption = '福岡のドライブスポットといえば！'
  po.body = 'この前はドライブではなく、遊覧船に乗って鍾乳洞を覗きにいけるアクティビティに参加してきました。'
  po.prefecture = 7
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/fukuoka_itoshima.jpeg"), filename: 'fukuoka_itoshima.jpeg')
  po.user = aoi # 福岡に馴染み深いサンプルユーザー
end

post_mentai = Post.find_or_create_by!(title: '明太子のお重') do |po|
  po.caption = '博多に来たら必ず行ってほしい'
  po.body = '明太子好きにはたまらない！重厚な雰囲気だけどカジュアルにランチで楽しめる。'
  po.prefecture = 7
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/fukuoka_mentaizyu.jpeg"),filename: 'fukuoka_mentaizyu.jpeg')
  po.user = aoi # 福岡に馴染み深いサンプルユーザー
end

post_unagi = Post.find_or_create_by!(title: '柳川') do |po|
  po.caption = 'うなぎも有名な場所'
  po.body = '福岡市からは少し離れていますが、美味しい鰻重と穏やかな川下りが楽しめますよ。'
  po.prefecture = 7
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/fukuoka_yanagawa.jpeg"),filename: 'fukuoka_yanagawa.jpeg')
  po.user = aoi # 福岡に馴染み深いサンプルユーザー
end

post_winter = Post.find_or_create_by!(title: '竜王スキー場') do |po|
  po.caption = '関東のスキー場といえばここ！'
  po.body = '関東に住まいの方に人気のスキー場。上の方に登ると、素敵な景色と共にビールも飲めちゃいます！'
  po.prefecture = 20
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/nagano_ryuo.jpeg"),filename: 'nagano_ryuo.jpeg')
  po.user = dan # 東京に馴染み深いサンプルユーザー
end

post_kanto = Post.find_or_create_by!(title: '秩父') do |po|
  po.caption = '東京から日帰りドライブにおすすめ'
  po.body = '秩父では荒川のライン下りが楽しいですよ！ランチはここがお気に入り。新鮮なジビエを岩の上で焼いて、きのこもたっぷり、自然の中で味わえる贅沢ランチです！'
  po.prefecture = 11
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/saitama_chichibu.jpg"),filename: 'saitama_chichibu.jpg')
  po.user = dan # 東京に馴染み深いサンプルユーザー
end

Post.find_or_create_by!(title: '浅草寺') do |po|
  po.caption = '日本の象徴的な観光スポット'
  po.body = '浅草寺の雷門が有名ですが、奥に進んだ場所から見えるこの眺めもおすすめです。夜は空いているので写真も撮りやすいですよ。'
  po.prefecture = 13
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tokyo_asakusa.jpeg"),filename: 'tokyo_asakusa.jpeg')
  po.user = dan # 東京に馴染み深いサンプルユーザー
end

Post.find_or_create_by!(title: '渋谷スカイ') do |po|
  po.caption = '渋谷にできた高層商業施設の屋上！'
  po.body = '入場料は少しお高めですが、ここからの展望は本当に最高！芝生があるのでゆっくりできますよ。'
  po.prefecture = 13
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tokyo_shibuya.jpg"),filename: 'tokyo_shibuya.jpg')
  po.user = dan # 東京に馴染み深いサンプルユーザー
end

Post.find_or_create_by!(title: '青川') do |po|
  po.caption = '付知川の清流'
  po.body = '本当に今まで見た川の中で一番エメラルド色！心も癒されるので、自然が好きな人にはぜひ訪れていただきたい！'
  po.prefecture = 21
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/gifu_river.jpeg"),filename: 'gifu_river.jpeg')
  po.user = ritsu # 岐阜に馴染み深いサンプルユーザー
end

Post.find_or_create_by!(title: '白川郷') do |po|
  po.caption = 'ここでしか見れない景色'
  po.body = '観光地として日本人にとっては馴染み深いですが、海外から来た人はあまり知らないかも。感動すること間違いなし！'
  po.prefecture = 21
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/gifu_shirakawago.jpg"),filename: 'gifu_shirakawago.jpg')
  po.user = ritsu # 岐阜に馴染み深いサンプルユーザー
end

Post.find_or_create_by!(title: '神戸') do |po|
  po.caption = '県名よりもよく知られている場所'
  po.body = '程よく品もあるエリア。遊ぶスポットもたくさんある、栄えた場所です。住む場所としても人気があります！'
  po.prefecture = 28
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hyogo_kobe.jpeg"),filename: 'hyogo_kobe.jpeg')
  po.user = yuma # 旅行好きのサンプルユーザー
end

Post.find_or_create_by!(title: '江ノ電') do |po|
  po.caption = 'ドライブも良し、電車旅も良し'
  po.body = '関東エリアに住まいの人々は定期的に足を運ぶような場所。気軽に海を眺めに行けます。'
  po.prefecture = 14
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kanagawa_enoden.jpg"),filename: 'kanagawa_enoden.jpg')
  po.user = yuma # 旅行好きのサンプルユーザー
end

Post.find_or_create_by!(title: '鴨川') do |po|
  po.caption = '京都の代表的な景色'
  po.body = '5月から夏にかけては川沿いに川床が出されることでも有名。ランクの高い飲食店も多く、鴨川を眺めながら贅沢な食事の時間を過ごせます。'
  po.prefecture = 26
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kyoto_kamogawa.jpeg"),filename: 'kyoto_kamogawa.jpeg')
  po.user = yuma # 旅行好きのサンプルユーザー
end

Post.find_or_create_by!(title: '京都で日本酒') do |po|
  po.caption = 'お酒好きにはたまりません！'
  po.body = '日本酒の飲み比べに加えて、京都では、おちょこも選べちゃうお店が多い！'
  po.prefecture = 26
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kyoto_nihonsyu.jpg"),filename: 'kyoto_nihonsyu.jpg')
  po.user = yuma # 旅行好きのサンプルユーザー
end

Post.find_or_create_by!(title: '東京ドイツ村') do |po|
  po.caption = '名前は東京だけど千葉にあるよ！'
  po.body = '年中平和な雰囲気が漂っているテーマパーク！でも、冬のイルミネーションの時期は一味違います！！規模が桁違いの、すばらしい景色が観れるので、ぜひこの冬訪れてみてください！'
  po.prefecture = 12
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/chiba_doitumura.jpeg"),filename: 'chiba_doitumura.jpeg')
  po.user = yuka # 千葉に馴染みの深いユーザー
end

Post.find_or_create_by!(title: 'いすみ市') do |po|
  po.caption = '星を見るならここ'
  po.body = '田舎町ではありますが、グランピング施設が多く点在しており、喧騒から離れて自然の中で癒されたい時におすすめのスポットです。'
  po.prefecture = 12
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/chiba_isumi.jpg"),filename: 'chiba_isumi.jpg')
  po.user = yuka # 千葉に馴染みの深いユーザー
end

Post.find_or_create_by!(title: 'Tokyo Tower') do |po|
  po.caption = 'A beautiful tower'
  po.body = 'The color change on each day. You can see the tower in mostly red but sometimes other colors.'
  po.prefecture = 13
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tokyo_tower.jpeg"),filename: 'tokyo_tower.jpeg')
  po.user = henry # 日本生活中級者のユーザー
end

Post.find_or_create_by!(title: 'Kamosui') do |po|
  po.caption = 'Aquarium'
  po.body = 'I visited Yamagata and found this beautiful aquarium. It was amazing.'
  po.prefecture = 6
  po.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yamagata_kamosui.jpeg"),filename: 'yamagata_kamosui.jpeg')
  po.user = henry # 日本生活中級者のユーザー
end

# 以下、相談室カテゴリデータ
Category.find_or_create_by!(name: 'マナー')
Category.find_or_create_by!(name: 'イベント')
Category.find_or_create_by!(name: '常識')
Category.find_or_create_by!(name: '食事')
Category.find_or_create_by!(name: '居住地')
Category.find_or_create_by!(name: '仕事')

# 以下、相談室データ
topic_manner = Category.find_by(name: 'マナー').counseling_rooms.find_or_create_by!(topic: 'マナーを知りたい！') do |room|
  room.user = filipp
  room.detail = '家に入るとき靴を脱いだり、食べる時に食器を持つのは最近知りました。よく海外から来た人に対して思う、直してほしいマナーがあれば教えてください。'
end

topic_music_fes = Category.find_by(name: 'イベント').counseling_rooms.find_or_create_by!(topic: '音楽フェス') do |room|
  room.user = bolek
  room.detail = '東京に住み始めました。東京かその周辺で、おすすめの音楽フェスがあれば、情報共有しましょう'
  room.topic_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/music_fes.jpeg"),filename: 'music_fes.jpeg')
end

topic_transportation = Category.find_by(name: '常識').counseling_rooms.find_or_create_by!(topic: '交通機関') do |room|
  room.user = bolek
  room.detail = '電車やバスの乗り方にいつも困ってしまう。支払い方も最初に払ったり後に払ったり。説明してくれる人いませんか。'
end

topic_moral = Category.find_by(name: '常識').counseling_rooms.find_or_create_by!(topic: '日本で大事にされている常識') do |room|
  room.user = koharu
  room.detail = '日本で大事にされている常識を紹介していきたいなと思います！みんなのいろんな意見が聞きたいです。'
end

topic_dishes = Category.find_by(name: '食事').counseling_rooms.find_or_create_by!(topic: 'びっくりした日本料理') do |room|
  room.user = filipp
  room.detail = '日本にくるまで知らなかった料理がたくさんありました！最近は「もんじゃ」にびっくり。美味しかった！みんなのびっくり日本料理あれば知りたい!'
  room.topic_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/monzya.jpeg"),filename: 'monzya.jpeg')
end

topic_table_manner = Category.find_by(name: '食事').counseling_rooms.find_or_create_by!(topic: '食べる時のマナー') do |room|
  room.user = yuko
  room.detail = '日本では暗黙の了解として気をつけている食べる時のいろんなマナーを話せたらいいなと思います！'
end

topic_residence = Category.find_by(name: '居住地').counseling_rooms.find_or_create_by!(topic: '住みやすい場所') do |room|
  room.user = sana
  room.detail = 'どこの県も素敵で住む場所が選べません。いいところあれば知りたいです。'
end

topic_job_search = Category.find_by(name: '仕事').counseling_rooms.find_or_create_by!(topic: '仕事探しのやり方') do |room|
  room.user = char
  room.detail = 'いろんな仕事探しのサイトがあるけど、日本語がネイティブじゃない人に向けておすすめの転職サイトとか仕事探しの方法があれば知りたい！'
end

topic_job_offer = Category.find_by(name: '仕事').counseling_rooms.find_or_create_by!(topic: 'お仕事募集') do |room|
  room.user = dan
  room.detail = '日本語が堪能じゃない人でもOKのお仕事募集を紹介しています。よかったら気軽に参加だけでもいいので覗いてみてください！'
end

topic_job_hunting = Category.find_by(name: '仕事').counseling_rooms.find_or_create_by!(topic: '就職活動で必要な準備') do |room|
  room.user = henry
  room.detail = '日本の企業に転職をしたいと思っています。転職活動のことでたくさん悩みがあるけど、教えてくれる人いたら参加お願いします。'
end

# 以下、相談室の参加者データ
topic_manner.participations.find_or_create_by!(user_id: yuma.id) do |participation|
  participation.status = true
end
topic_manner.participations.find_or_create_by!(user_id: henry.id) do |participation|
  participation.status = true
end
topic_manner.participations.find_or_create_by!(user_id: ritsu.id) do |participation|
  participation.status = true
end
topic_manner.participations.find_or_create_by!(user_id: amado.id) do |participation|
  participation.status = false
end

topic_music_fes.participations.find_or_create_by!(user_id: jacobo.id) do |participation|
  participation.status = true
end
topic_music_fes.participations.find_or_create_by!(user_id: hana.id) do |participation|
  participation.status = true
end
topic_music_fes.participations.find_or_create_by!(user_id: abramo.id) do |participation|
  participation.status = true
end
topic_music_fes.participations.find_or_create_by!(user_id: ambre.id) do |participation|
  participation.status = false
end
topic_music_fes.participations.find_or_create_by!(user_id: ritsu.id) do |participation|
  participation.status = false
end

topic_transportation.participations.find_or_create_by!(user_id: ambre.id) do |participation|
  participation.status = true
end
topic_transportation.participations.find_or_create_by!(user_id: henry.id) do |participation|
  participation.status = true
end
topic_transportation.participations.find_or_create_by!(user_id: ritsu.id) do |participation|
  participation.status = false
end
topic_transportation.participations.find_or_create_by!(user_id: jacobo.id) do |participation|
  participation.status = false
end

topic_moral.participations.find_or_create_by!(user_id: brunello.id) do |participation|
  participation.status = true
end
topic_moral.participations.find_or_create_by!(user_id: henry.id) do |participation|
  participation.status = true
end
topic_moral.participations.find_or_create_by!(user_id: emi.id) do |participation|
  participation.status = true
end
topic_moral.participations.find_or_create_by!(user_id: amado.id) do |participation|
  participation.status = false
end
topic_moral.participations.find_or_create_by!(user_id: james.id) do |participation|
  participation.status = false
end

topic_dishes.participations.find_or_create_by!(user_id: james.id) do |participation|
  participation.status = true
end
topic_dishes.participations.find_or_create_by!(user_id: mio.id) do |participation|
  participation.status = true
end
topic_dishes.participations.find_or_create_by!(user_id: hana.id) do |participation|
  participation.status = true
end
topic_dishes.participations.find_or_create_by!(user_id: brunello.id) do |participation|
  participation.status = true
end
topic_dishes.participations.find_or_create_by!(user_id: celina.id) do |participation|
  participation.status = false
end
topic_dishes.participations.find_or_create_by!(user_id: ambre.id) do |participation|
  participation.status = false
end

topic_table_manner.participations.find_or_create_by!(user_id: amado.id) do |participation|
  participation.status = true
end
topic_table_manner.participations.find_or_create_by!(user_id: brunello.id) do |participation|
  participation.status = true
end
topic_table_manner.participations.find_or_create_by!(user_id: faina.id) do |participation|
  participation.status = true
end
topic_table_manner.participations.find_or_create_by!(user_id: celina.id) do |participation|
  participation.status = false
end
topic_table_manner.participations.find_or_create_by!(user_id: ritsu.id) do |participation|
  participation.status = false
end

topic_residence.participations.find_or_create_by!(user_id: faina.id) do |participation|
  participation.status = true
end
topic_residence.participations.find_or_create_by!(user_id: emi.id) do |participation|
  participation.status = true
end
topic_residence.participations.find_or_create_by!(user_id: celina.id) do |participation|
  participation.status = false
end

topic_job_search.participations.find_or_create_by!(user_id: henry.id) do |participation|
  participation.status = true
end
topic_job_search.participations.find_or_create_by!(user_id: amado.id) do |participation|
  participation.status = true
end
topic_job_search.participations.find_or_create_by!(user_id: brunello.id) do |participation|
  participation.status = true
end
topic_job_search.participations.find_or_create_by!(user_id: juana.id) do |participation|
  participation.status = false
end
topic_job_search.participations.find_or_create_by!(user_id: celina.id) do |participation|
  participation.status = false
end

topic_job_offer.participations.find_or_create_by!(user_id: emi.id) do |participation|
  participation.status = true
end
topic_job_offer.participations.find_or_create_by!(user_id: abramo.id) do |participation|
  participation.status = true
end
topic_job_offer.participations.find_or_create_by!(user_id: brunello.id) do |participation|
  participation.status = true
end
topic_job_offer.participations.find_or_create_by!(user_id: henry.id) do |participation|
  participation.status = false
end
topic_job_offer.participations.find_or_create_by!(user_id: ambre.id) do |participation|
  participation.status = false
end

topic_job_hunting.participations.find_or_create_by!(user_id: ritsu.id) do |participation|
  participation.status = true
end
topic_job_hunting.participations.find_or_create_by!(user_id: juana.id) do |participation|
  participation.status = true
end
topic_job_hunting.participations.find_or_create_by!(user_id: james.id) do |participation|
  participation.status = true
end
topic_job_hunting.participations.find_or_create_by!(user_id: jacobo.id) do |participation|
  participation.status = false
end

# 以下、タグのデータ
post_tag_kanto   = PostTag.find_or_create_by!(name: '関東')
post_tag_local   = PostTag.find_or_create_by!(name: '地方')
post_tag_gourmet = PostTag.find_or_create_by!(name: 'B級グルメ')
post_tag_drive   = PostTag.find_or_create_by!(name: 'ドライブ')
post_tag_winter  = PostTag.find_or_create_by!(name: '冬')

room_tag_tokyo     = RoomTag.find_or_create_by!(name: '東京')
room_tag_friend_ja = RoomTag.find_or_create_by!(name: '友達作り')
room_tag_friend_en = RoomTag.find_or_create_by!(name: 'to make friends')
room_tag_trip_ja   = RoomTag.find_or_create_by!(name: '旅行者')
room_tag_trip_en   = RoomTag.find_or_create_by!(name: 'travelers')
room_tag_migrant   = RoomTag.find_or_create_by!(name: '日本移住')

# 以下、投稿タグの紐付けデータ
post_kanto.related_post_tags.find_or_create_by!(post_tag_id: post_tag_kanto.id)

post_mentai.related_post_tags.find_or_create_by!(post_tag_id: post_tag_local.id)
post_mentai.related_post_tags.find_or_create_by!(post_tag_id: post_tag_gourmet.id)

post_unagi.related_post_tags.find_or_create_by!(post_tag_id: post_tag_local.id)

post_winter.related_post_tags.find_or_create_by!(post_tag_id: post_tag_local.id)
post_winter.related_post_tags.find_or_create_by!(post_tag_id: post_tag_winter.id)

post_drive.related_post_tags.find_or_create_by!(post_tag_id: post_tag_drive.id)

# 以下、相談室タグの紐付けデータ
topic_music_fes.related_room_tags.find_or_create_by!(room_tag_id: room_tag_tokyo.id)
topic_music_fes.related_room_tags.find_or_create_by!(room_tag_id: room_tag_friend_ja.id)
topic_music_fes.related_room_tags.find_or_create_by!(room_tag_id: room_tag_friend_en.id)

topic_dishes.related_room_tags.find_or_create_by!(room_tag_id: room_tag_trip_ja.id)
topic_dishes.related_room_tags.find_or_create_by!(room_tag_id: room_tag_trip_en.id)

topic_residence.related_room_tags.find_or_create_by!(room_tag_id: room_tag_migrant.id)

puts 'seedの実行が完了しました'