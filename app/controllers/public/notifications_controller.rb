class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification.notifiable_path(params[:locale])
  end

  def clear_all
    current_user.notifications.update_all(read: true)
    redirect_to request.referer
  end

end
