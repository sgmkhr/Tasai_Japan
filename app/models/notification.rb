class Notification < ApplicationRecord
  
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  
  # 各notifiableモデルから表示する通知メッセージ取得メソッドを呼び出す
  def message
    notifiable.notification_message
  end
  
  # 各notifiableモデル通知クリック時のパス先指定メソッドを呼び出す
  def notifiable_path
    notifiable.notification_path
  end
  
end
