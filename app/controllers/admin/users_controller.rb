class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
  end

  def index
    @users = User.all #退会済みも含む全ユーザーを表示
  end
  
  def cancel
    @user.update(is_active: true)
    #このあと非同期処理 jsファイルが呼び出される
  end
  
  def withdraw
    @user.update(is_active: false)
    #このあと非同期処理 jsファイルが呼び出される
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: I18n.t('admin.users.destroy.notice')
  end
  
  private
  
  def set_selected_user
    @user = User.find_by(canonical_name: params[:canonical_name])
  end
end
