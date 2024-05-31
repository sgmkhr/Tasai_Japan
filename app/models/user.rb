class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum position: { beginner: 0, intermediate: 1, veteran: 2 }

  with_options presence: true do
    validates :email,          uniqueness: true
    validates :last_name
    validates :first_name
    validates :canonical_name, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/ }
    validates :public_name
    validates :position
  end

  validates :introduction, length: { maximum: 200 }

end
