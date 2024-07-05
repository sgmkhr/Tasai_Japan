class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
    @keyword    = params[:keyword]
    @prefecture = params[:prefecture]
    @sort       = params[:sort]
    @user  = User.find_by(canonical_name: params[:canonical_name])
    @posts = @user.posts&.where(is_published: true)
    
    @posts = @posts.search_with_user_for(@keyword, @user) if @keyword.present?
    @posts = @posts.where(prefecture: @prefecture)        if @prefecture.present? && (@prefecture != 'unspecified')
    @posts = @sort == 'old' ? @posts.old : (@sort == 'favorites_count' ? @posts&.sort_by { |post| -post.post_favorites.count } : @posts.latest)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end        #sort_byで取得したデータの場合に必要な、pageメソッドの配列レシーバ対応化

  def index
    @keyword = params[:keyword]
    @sort    = params[:sort]
    @users = User.all #退会済みユーザーも含め表示
    @users = @users.search_for(@keyword) if @keyword.present?
    @users = @sort == 'latest' ? @users.latest : ( @sort == 'posts_count' ? @users.sort_by { |user| -user.posts.count } : @users.old )
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(18)
  end        #sort_byで取得したデータの場合に必要な、pageメソッドの配列レシーバ対応化
  
  def cancel
    @user.update(is_active: true)
    redirect_to request.referer
  end
  
  def withdraw
    @user.update(is_active: false)
    @user.posts.update_all(is_published: false) #公開中の投稿全て非公開に変更
    sign_out(@user)
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
