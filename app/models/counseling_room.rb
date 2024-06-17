class CounselingRoom < ApplicationRecord

  has_one_attached :topic_image

  belongs_to :user
  belongs_to :category

  has_many :participations,    dependent: :destroy
  has_many :opinions,          dependent: :destroy
  has_many :related_room_tags, dependent: :destroy

  has_many :room_tags, through: :related_room_tags

  scope :latest, -> { order(created_at: :desc) }
  scope :old,    -> { order(created_at: :asc) }

  validates :topic,  presence: true, length: { maximum: 100 }, uniqueness: { scope: :category }
  validates :detail, presence: true, length: { maximum: 2000 }

  # トピック画像を指定サイズへ圧縮してからデータ表示するメソッド
  def get_topic_image(width, height)
    topic_image.variant(resize_to_limit: [width, height]).processed
  end

  # 指定のカテゴリ内でのキーワード検索メソッド
  def self.search_with_category_for(content)
    CounselingRoom.where(['topic LIKE(?) OR detail LIKE(?)', "%#{content}%", "%#{content}%"])
  end

  # タグ情報を保存するためのメソッド
  def save_tags(save_tag_names)
    current_tag_names = self.room_tags.pluck(:name) unless self.room_tags.nil?
    old_tag_names = current_tag_names - save_tag_names
    new_tag_names = save_tag_names - current_tag_names
    old_tag_names.each do |old_tag_name|
      room_tag = RoomTag.find_by(name: old_tag_name)
      RelatedRoomTag.find_by(room_tag_id: room_tag.id).destroy
    end
    new_tag_names.each do |new_tag_name|
      room_tag = RoomTag.find_or_create_by(name: new_tag_name)
      self.room_tags << room_tag
    end
  end

end
