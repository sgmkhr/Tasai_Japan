class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
    @user  = User.find_by(canonical_name: params[:canonical_name])
    @posts      = @user.posts&.includes(:post_tags)
    @keyword    = params[:keyword]
    @prefecture = params[:prefecture]
    @sort       = params[:sort]
    @posts = @posts&.latest if (@sort == 'latest') || (@sort.nil?)
    @posts = @posts&.old    if @sort == 'old'
    @posts = @posts&.where(prefecture: @prefecture) if @prefecture.present? && (@prefecture != 'unspecified')
    @posts = @posts&.search_with_user_for(@keyword, @user) if @keyword.present?
    @posts = @posts&.includes(:post_favorites).sort_by { |post| -post.post_favorites.count } if @sort == 'favorites_count'
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end

  def index #退会済みユーザーも含め表示
    if params[:latest]                #ソート切り替え(新参順)
      @users = User.latest
    elsif params[:old]                #ソート切り替え(古参順)
      @users = User.old
    elsif params[:posts_count]        #ソート切り替え(投稿数順)
      users = User.all.sort {|a,b| 
        b.posts.size <=> a.posts.size
      }
      @users = Kaminari.paginate_array(users)
    elsif params[:content]            #キーワード検索順
      @users = User.search_for(params[:content])
    else
      @users = User.all
    end
    @users = @users.page(params[:page]).per(18)
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
