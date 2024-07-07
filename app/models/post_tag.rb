class PostTag < ApplicationRecord
  has_many :related_post_tags, dependent: :destroy

  has_many :posts, through: :related_post_tags

  validates :name, presence: true, uniqueness: true

  # 紐付いた投稿の多い順に並べ替えるメソッド
  def self.sort_by_popularity
    PostTag.all.sort_by { |tag| -tag.related_post_tags.count }
  end
end
