class PostTag < ApplicationRecord
  
  has_many :related_post_tags, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
end
