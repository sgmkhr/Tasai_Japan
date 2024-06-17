class Category < ApplicationRecord

  has_many :counseling_rooms, dependent: :destroy
  
  scope :latest, -> { order(created_at: :desc) }
  scope :old,    -> { order(created_at: :asc) }

  validates :name, presence: true, uniqueness: true
  
  # キーワード検索のメソッド
  def self.search_for(content)
    Category.where('name LIKE ?', "%#{content}%")
  end

end
