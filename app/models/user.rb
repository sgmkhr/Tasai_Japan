class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

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

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-profile-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #ポジションによって別のcssクラスを呼び出すメソッド
  def get_class_associated_with_position
    if position == 'beginner'
      return 'position-beginner'
    elsif position == 'intermediate'
      return 'position-intermediate'
    else
      return 'position-veteran'
    end
  end
  
end