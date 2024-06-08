class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,   except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :withdraw, :unsubscribe]
  before_action :set_current_user,    except: [:show, :index]
  
  def show
    @user  = User.find_by(canonical_name: params[:canonical_name])
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
      @posts = @user.posts.latest.page(params[:page]).per(12)
    end
    
    if params[:content_in_bookmarks]
      @bookmarked_posts = current_user.search_with_bookmarks_for(params[:content_in_bookmarks]).page(params[:page]).per(12)
    else
      @bookmarked_posts = current_user.bookmarked_posts.latest.page(params[:page]).per(12)
    end
    
    unless ProfileView.find_by(viewer_id: current_user.id, viewed_id: @user.id)
      current_user.active_profile_views.create(viewed_id: @user.id)
    end
  end

  def index
    if params[:latest]
      @users = User.where(is_active: true).latest.page(params[:page]).per(18)
    elsif params[:old]
      @users = User.where(is_active: true).old.page(params[:page]).per(18)
    elsif params[:posts_count]
      users = User.where(is_active: true).sort {|a,b| 
        b.posts.size <=> a.posts.size
      }
      @users = Kaminari.paginate_array(users).page(params[:page]).per(18)
    elsif params[:content]
      @users = User.search_for(params[:content]).where(is_active: true).page(params[:page]).per(18)
    else
      @users = User.where(is_active: true).page(params[:page]).per(18) #退会済みユーザーは表示しない
    end
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
    
  def user_params
    params.require(:user).permit(:last_name, :first_name, :public_name, :email, :position, :introduction, :profile_image)
  end
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to user_path(current_user.canonical_name), alert: I18n.t('guestuser.validates')
    end
  end
  
  def ensure_correct_user
    user = User.find_by(canonical_name: params[:canonical_name])
    unless user == current_user
      redirect_to users_path, alert: I18n.t('users.incorrect_user.validates')
    end
  end
  
  def set_current_user
    @user = current_user
  end
  
end
