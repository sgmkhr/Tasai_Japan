class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,   except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :insite, :withdraw, :unsubscribe]
  before_action :set_current_user,    except: [:show, :index]

  def show
    @user  = User.find_by(canonical_name: params[:canonical_name])
    #以下、投稿データの取得
    if params[:latest]              #ソート切り替え(作成新しい順)
      @posts = @user.posts.latest
    elsif params[:old]              #ソート切り替え(作成古い順)
      @posts = @user.posts.old
    elsif params[:favorites_count]  #ソート切り替え(いいね多い順)
      posts = @user.posts.sort {|a,b|
        b.post_favorites.size <=> a.post_favorites.size
      }
      @posts = Kaminari.paginate_array(posts)
    elsif params[:content]          #キーワード検索
      @posts = Post.search_with_user_for(params[:content], @user)
    else
      @posts = @user.posts.latest
    end
    @posts = @posts.page(params[:page]).per(12)
    #以下、マイページ内のみ表示のブックマーク投稿データ取得
    if params[:content_in_bookmarks]  #ブックマーク内キーワード検索
      @bookmarked_posts = current_user.search_with_bookmarks_for(params[:content_in_bookmarks])
    else
      @bookmarked_posts = current_user.bookmarked_posts.latest
    end
    @bookmarked_posts = @bookmarked_posts.page(params[:page]).per(12)
    #以下、マイページ内のみ表示のフォローユーザー投稿データ取得
    friends = current_user.followings
    if friends.present?
      @friends_posts = Post.where(user_id: friends.ids)
      if @friends_posts.present?
        @friends_posts = @friends_posts.latest.page(params[:page]).per(12)
      end
    else
      @friends_posts = nil
    end
    #以下、閲覧カウント
    unless ProfileView.find_by(viewer_id: current_user.id, viewed_id: @user.id)
      current_user.active_profile_views.create(viewed_id: @user.id)
    end
  end

  def index #退会済みユーザーは表示しない
    if params[:latest]            #ソート切り替え(新参順)
      @users = User.where(is_active: true).latest
    elsif params[:old]            #ソート切り替え(古参順)
      @users = User.where(is_active: true).old
    elsif params[:posts_count]    #ソート切り替え(投稿数順)
      users = User.where(is_active: true).sort {|a,b|
        b.posts.size <=> a.posts.size
      }
      @users = Kaminari.paginate_array(users)
    elsif params[:content]        #キーワード検索
      @users = User.search_for(params[:content]).where(is_active: true)
    else
      @users = User.where(is_active: true)
    end
    @users = @users.page(params[:page]).per(18)
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

  def insite
    @rooms_managing = @user.counseling_rooms.page(params[:page]).per(20)
    @rooms_participated_in = []
    @rooms_applying_for = []
    true_participations = Participation.where(user_id: @user.id, status: true)
    if true_participations
      true_participations.each do |participation|
        @rooms_participated_in << participation.counseling_room
      end
    end
    @rooms_participated_in = Kaminari.paginate_array(@rooms_participated_in).page(params[:page]).per(20)
    false_participations = Participation.where(user_id: @user.id, status: false)
    if false_participations
      false_participations.each do |participation|
        @rooms_applying_for << participation.counseling_room
      end
    end
    @rooms_applying_for = Kaminari.paginate_array(@rooms_applying_for).page(params[:page]).per(20)
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

  def ensure_correct_user
    if params[:canonical_name]
      user = User.find_by(canonical_name: params[:canonical_name])
    else
      user = User.find_by(canonical_name: params[:user_canonical_name])
    end
    unless user == current_user
      redirect_to users_path, alert: I18n.t('users.incorrect_user.validates')
    end
  end

  def set_current_user
    @user = current_user
  end

end
