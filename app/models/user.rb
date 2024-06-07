class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :counseling_rooms, dependent: :destroy
  has_many :participations, dependent: :destroy

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

  def self.search_for(content)
    return User.all if content == ''
    User.where(['public_name LIKE(?) OR canonical_name LIKE(?) OR introduction LIKE(?)', "%#{content}%", "%#{content}%", "%#{content}%"])
  end

  # 相談室の参加ステータスを確認するためのメソッド
  def get_participation_status(room)
    if current_user == room.user
      I18n.t('participations.creator')
    elsif participations.!exists?(counseling_room_id: room.id)
      I18n.t('participations.not_participating')
    elsif participations.find_by(counseling_room_id: room.id).status
      I18n.t('participations.participating')
    else
      I18n.t('participations.applying')
    end
  end

end