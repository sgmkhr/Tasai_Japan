class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_selected_user, except: [:index]
  
  def show
    if params[:latest]
      @posts = @user.posts.latest.page(params[:page]).per(12)
    elsif params[:old]
      @posts = @user.posts.old.page(params[:page]).per(12)
    elsif params[:favorites_count]
      posts = @user.posts.sort {|a,b| 
        b.post_favorites.size <=> a.post_favorites.size
      }
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(12)
    elsif params[:content]
      @posts = Post.search_with_user_for(params[:content], @user).page(params[:page]).per(12)
    else
      @posts = @user.posts.page(params[:page]).per(12)
    end
  end

  def index
    if params[:latest]
      @users = User.latest.page(params[:page]).per(18)
    elsif params[:old]
      @posts = User.old.page(params[:page]).per(18)
    elsif params[:posts_count]
      users = User.all.sort {|a,b| 
        b.posts.size <=> a.posts.size
      }
      @users = Kaminari.paginate_array(users).page(params[:page]).per(18)
    elsif params[:content]
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
