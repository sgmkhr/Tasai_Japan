class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :post_image

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

  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content)
    return Post.all if content == ''
    Post.where(['title LIKE(?) OR caption LIKE(?) OR body LIKE(?)', "%#{content}%", "%#{content}%", "%#{content}%"])
  end
  
  def self.search_with_user_for(content, user)
    return Post.where(user_id: user.id) if content == ''
    Post.where(user_id: user.id).where(['title LIKE(?) OR caption LIKE(?) OR body LIKE(?)', "%#{content}%", "%#{content}%", "%#{content}%"])
  end

end
