class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
    @user  = User.find_by(canonical_name: params[:canonical_name])
    @posts      = @user.posts&.where(is_published: true)&.includes(:post_tags).includes(:post_favorites)
    @keyword    = params[:keyword]
    @prefecture = params[:prefecture]
    @sort       = params[:sort]
    @posts = @posts.search_with_user_for(@keyword, @user) if @keyword.present?
    @posts = @posts.where(prefecture: @prefecture)        if @prefecture.present? && (@prefecture != 'unspecified')
    @posts = @posts.latest if (@sort == 'latest') || (@sort.nil?)
    @posts = @posts.old    if @sort == 'old'
    @posts = @posts.sort_by { |post| -post.post_favorites.count } if @sort == 'favorites_count'
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end        #sort_byで取得したデータの場合に必要な、pageメソッドの配列レシーバ対応化

  def index #退会済みユーザーも含め表示
    @users   = User.includes(:posts)
    @keyword = params[:keyword]
    @sort    = params[:sort]
    @users = @users.search_for(@keyword) if @keyword.present?
    @users = @users.latest               if @sort == 'latest'
    @users = @users.old                  if @sort == 'old'
    @users = @users.sort_by { |user| -user.posts.count } if @sort == 'posts_count'
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(18)
  end        #sort_byで取得したデータの場合に必要な、pageメソッドの配列レシーバ対応化
  
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
