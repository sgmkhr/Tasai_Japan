class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
    if params[:latest]                #ソート切り替え(作成新着順)
      @posts = @user.posts.latest
    elsif params[:old]                #ソート切り替え(作成古い順)
      @posts = @user.posts.old
    elsif params[:favorites_count]    #ソート切り替え(いいね多い順)
      posts = @user.posts.sort {|a,b| 
        b.post_favorites.size <=> a.post_favorites.size
      }
      @posts = Kaminari.paginate_array(posts)
    elsif params[:content]            #キーワード検索
      @posts = Post.search_with_user_for(params[:content], @user)
    else
      @posts = @user.posts
    end
    @posts = @posts.page(params[:page]).per(12)
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
