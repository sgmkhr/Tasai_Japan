class RelatedPostTag < ApplicationRecord
  
  belongs_to :post_tag
  belongs_to :post
  
end
