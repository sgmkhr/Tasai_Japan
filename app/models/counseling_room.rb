class CounselingRoom < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :participations, dependent: :destroy

  validates :topic,  presence: true, length: { maximum: 100 }, uniqueness: { scope: :category }
  validates :detail, presence: true, length: { maximum: 2000 }

end
