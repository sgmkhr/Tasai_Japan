class Post < ApplicationRecord
  include Notifiable

  has_one_attached :post_image

  belongs_to :user

  with_options dependent: :destroy do
    has_many :comments
    has_many :post_favorites
    has_many :bookmarks
    has_many :post_views
    has_many :related_post_tags
  end

  has_many :post_tags, through: :related_post_tags

  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :latest, -> { order(created_at: :desc) }
  scope :old,    -> { order(created_at: :asc) }
  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }

  enum prefecture: {
    unspecified: 0, hokkaido: 1, aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7,
    ibaraki: 8, tochigi: 9, gunma: 10, saitama: 11, chiba: 12, tokyo: 13, kanagawa: 14, niigata: 15,
    toyama: 16, ishikawa: 17, fukui: 18, yamanashi: 19, nagano: 20, gifu: 21, shizuoka: 22, aichi: 23,
    mie: 24, shiga: 25, kyoto: 26, osaka: 27, hyogo: 28, nara: 29, wakayama: 30, tottori: 31, shimane: 32,
    okayama: 33, hiroshima: 34, yamaguchi: 35, tokushima: 36, kagawa: 37, ehime: 38, kouchi: 39, fukuoka: 40,
    saga: 41, nagasaki: 42, kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46, okinawa: 47, others: 48
  }

  with_options presence: true do
    validates :post_image
    validates :title, length: { maximum: 20 }
    validates :prefecture
  end

  validates :caption, length: { maximum: 100 }
  validates :body,    length: { maximum: 2000 }

  geocoded_by :address
  after_validation :geocode

  # データが作成されると直後に通知データも作成される
  after_create do
    records = user.followers.map do |follower|
      notifications.new(user_id: follower.id)
    end
    Notification.import records
  end

  # 表示する通知メッセージを取得するメソッド
  def notification_message
    I18n.t("notifications.messages.post", public_name: user.public_name, title: title)
  end

  # 通知クリック時のパス先指定のメソッド
  def notification_path(locale_params)
    post_path(self.id, locale: locale_params)
  end

  # 投稿画像を指定サイズへ圧縮してからデータ表示するメソッド
  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  # キーワード検索メソッド
  def self.search_for(content)
    Post.where(["title LIKE(?) OR caption LIKE(?) OR body LIKE(?)", "%#{content}%", "%#{content}%", "%#{content}%"])
  end

  # 各ユーザー詳細内でのキーワード検索メソッド
  def self.search_with_user_for(content, user)
    Post.where(user_id: user.id).where(["title LIKE(?) OR caption LIKE(?) OR body LIKE(?)", "%#{content}%", "%#{content}%", "%#{content}%"])
  end

  # 対象の投稿が既にいいねされているか確かめるメソッド
  def favorited_by?(user)
    post_favorites.exists?(user_id: user.id)
  end

  # 対象の投稿が既にブックマークされているか確かめるメソッド
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  # 投稿タグを保存するためのメソッド
  def save_tags(save_tag_names)
    current_tag_names = self.post_tags.pluck(:name) unless self.post_tags.nil?
    old_tag_names = current_tag_names - save_tag_names
    new_tag_names = save_tag_names - current_tag_names

    old_tag_names.each do |old_tag_name|
      post_tag = PostTag.find_by(name: old_tag_name)
      RelatedPostTag.find_by(post_tag_id: post_tag.id).destroy
    end

    new_tag_names.each do |new_tag_name|
      post_tag = PostTag.find_or_create_by(name: new_tag_name)
      self.post_tags << post_tag
    end
  end

  # 過去１週間の各日の投稿数データを取得するメソッド
  def self.past_week_count
    (0..6).map { |n| created_days_ago(n).count }.reverse
  end
end
