class Category < ApplicationRecord
  
  has_many :counseling_rooms, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
end
