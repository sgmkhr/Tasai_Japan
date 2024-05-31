# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user,     only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  def after_sign_in_path_for(resource)
    menu_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  private
  
  # 退会済みのアカウントをログインさせないための処理
  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    return unless @user
    if @user.valid_password?(params[:user][:password]) && !@user.is_active
      flash[:alert] = I18n.t('flash.alert.reject_inactive_user')
      redirect_to new_user_session_path
    end
  end
  
end
