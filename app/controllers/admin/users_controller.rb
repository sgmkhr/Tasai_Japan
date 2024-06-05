class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
    if params[:content]
      @posts = @user.posts.search_with_user_for(params[:content], @user).page(params[:page]).per(12)
    else
      @posts = @user.posts.page(params[:page]).per(12)
    end
  end

  def index
    if params[:content]
      @users = User.search_for(params[:content]).page(params[:page]).per(18)
    else
      @users = User.page(params[:page]).per(18) #退会済みも含む全ユーザーを表示
    end
  end
  
  def cancel
    @user.update(is_active: true)
    redirect_to request.referer
  end
  
  def withdraw
    @user.update(is_active: false)
    redirect_to request.referer
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
