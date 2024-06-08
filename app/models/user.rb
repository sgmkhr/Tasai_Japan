class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  with_options dependent: :destroy do
    has_many :posts
    has_many :comments
    has_many :counseling_rooms
    has_many :participations
    has_many :opinions
    has_many :post_favorites
    has_many :comment_favorites
    has_many :opinion_favorites
    has_many :bookmarks
    has_many :post_views
    has_many :active_profile_views,  class_name: 'ProfileView', foreign_key: 'viewer_id'
    has_many :passive_profile_views, class_name: 'ProfileView', foreign_key: 'viewed_id'
  end

  has_many :bookmarked_posts, through: :bookmarks, source: :post

  scope :latest, -> { order(created_at: :desc) }
  scope :old,    -> { order(created_at: :asc) }

  enum position: { beginner: 0, intermediate: 1, veteran: 2 }

  with_options presence: true do
    validates :email,          uniqueness: true
    validates :last_name
    validates :first_name
    validates :canonical_name, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/ }, length: { minimum: 1, maximum: 20 }
    validates :public_name
    validates :position
  end

  validates :introduction, length: { maximum: 200 }

  GUEST_USER_EMAIL = 'guest@example.com'

  #プロフィール画像がなければデフォルト画像を表示するメソッド
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-profile-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #ポジションによって別のcssクラスを呼び出すメソッド
  def get_class_associated_with_position
    return 'position-beginner'     if position == 'beginner'
    return 'position-intermediate' if position == 'intermediate'
    return 'position-veteran'
  end

  #ゲストログイン時のメソッド
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password       = SecureRandom.urlsafe_base64
      user.last_name      = 'guest'
      user.first_name     = 'user'
      user.public_name    = 'guestuser'
      user.canonical_name = 'guestuser'
      user.position       = 1
    end
  end

  # ゲストユーザーか確かめるためのメソッド
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # 相談室の参加ステータスを確認するためのメソッド
  def get_participation_status(room)
    if id == room.user_id
      I18n.t('participations.creator')
    elsif participations.exists?(counseling_room_id: room.id) && participations.find_by(counseling_room_id: room.id).status
      I18n.t('participations.participating')
    elsif participations.exists?(counseling_room_id: room.id)
      I18n.t('participations.applying')
    else
      I18n.t('participations.not_participating')
    end
  end

  def self.search_for(content)
    return User.all if content == ''
    User.where(['public_name LIKE(?) OR canonical_name LIKE(?) OR introduction LIKE(?)', "%#{content}%", "%#{content}%", "%#{content}%"])
  end

  def search_with_bookmarks_for(content)
    return self.bookmarked_posts if content == ''
    self.bookmarked_posts.where(['title LIKE(?) OR caption LIKE(?) OR body LIKE(?)', "%#{content}%", "%#{content}%", "%#{content}%"])
  end

end