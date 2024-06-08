class Category < ApplicationRecord

  has_many :counseling_rooms, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.search_for(content)
    return Category.all if content == ''
    Category.where('name LIKE ?', "%#{content}%")
  end

end
