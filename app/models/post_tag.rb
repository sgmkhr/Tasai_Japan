class PostTag < ApplicationRecord
  
  has_many :related_post_tags, dependent: :destroy
  
  has_many :posts, through: :related_post_tags
  
  validates :name, presence: true, uniqueness: true
  
end
