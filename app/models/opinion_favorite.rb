class OpinionFavorite < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :opinion

  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :opinion_id }

  # データが作成されると直後に通知データも作成される
  after_create do
    create_notification(user_id: opinion.user_id)
  end

  # 表示する通知メッセージを取得するメソッド
  def notification_message
    I18n.t("notifications.messages.opinion_favorite", public_name: user.public_name)
  end

  # 通知クリック時のパス先指定のメソッド
  def notification_path(locale_params)
    category_counseling_room_path(opinion.counseling_room.category.id, opinion.counseling_room.id, locale: locale_params)
  end
end
