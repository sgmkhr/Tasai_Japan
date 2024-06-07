class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :counseling_room

  validates :content, presence: true, length: { maximum: 100 }

end
