class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: [:edit, :update, :unsubscribe, :withdraw]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find_by(canonical_name: params[:canonical_name])
  end

  def index
    @users = User.where(is_active: true).page(params[:page]).per(20) #退会済みユーザーは表示しない
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user.canonical_name), notice: I18n.t('users.update.notice')
    else
      flash.now[:alert] = I18n.t('users.update.alert')
      render :edit
    end
  end
  
  def withdraw
    @user.update(is_active: false)
    reset_session
    redirect_to new_user_registration_path, notice: I18n.t('users.withdraw.notice')
  end

  def unsubscribe
  end
  
  private
  
  def set_current_user
    @user = current_user
  end
    
  def user_params
    params.require(:user).permit(:last_name, :first_name, :public_name, :email, :position, :introduction, :profile_image)
  end
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to user_path(current_user.canonical_name), alert: I18n.t('guestuser.edit.validates')
    end
  end
  
end
