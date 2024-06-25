class ApplicationController < ActionController::Base

  before_action :set_locale

  def set_locale #パスのパラメータを現在の言語I18n.localeに設定
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {}) #デフォルト値として現在の言語を指定
     { :locale => I18n.locale }.merge options
  end

  private

  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, alert: I18n.t('guestuser.validates')
    end
  end

end
