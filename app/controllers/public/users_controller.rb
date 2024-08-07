class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,   except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :insite, :withdraw, :unsubscribe]
  before_action :set_current_user,    except: [:show, :index]
  before_action :ensure_active_page,  only: [:show]

  def show
    @keyword              = params[:keyword]
    @prefecture           = params[:prefecture]
    @sort                 = params[:sort]
    @keyword_in_bookmarks = params[:keyword_in_bookmarks]
    @current_tab          = params[:current_tab]
    @user                 = User.find_by(canonical_name: params[:canonical_name])
    @posts            = @user.posts&.where(is_published: true)
    @bookmarked_posts = current_user.bookmarked_posts&.where(is_published: true)&.latest

    @posts = @posts.search_with_user_for(@keyword, @user) if @keyword.present?
    @posts = @posts.where(prefecture: @prefecture)        if @prefecture.present? && (@prefecture != "unspecified")
    @posts = @sort == "old" ? @posts.old : (@sort == "favorites_count" ? @posts&.sort_by { |post| -post.post_favorites.count } : @posts.latest)
    @bookmarked_posts = current_user.search_with_bookmarks_for(@keyword_in_bookmarks) if @keyword_in_bookmarks.present?

    @posts            = Kaminari.paginate_array(@posts).page(params[:normal_page]).per(12)
    @bookmarked_posts = Kaminari.paginate_array(@bookmarked_posts).page(params[:bookmarks_page]).per(12)
    @draft_posts      = @user.posts&.where(is_published: false)&.latest&.page(params[:drafts_page])&.per(12)
    @current_tab = "user_posts_tab" unless @current_tab.present?

    # 以下、マイページ内のみ表示のフォローユーザー投稿データ取得
    if current_user.followings
      @friends_posts = Post.where(user_id: current_user.followings.ids)&.where(is_published: true)&.latest&.page(params[:friends_page])&.per(12)
    else
      @friends_posts = []
    end

    # 以下、閲覧カウント
    unless ProfileView.find_by(viewer_id: current_user.id, viewed_id: @user.id)
      current_user.active_profile_views.create(viewed_id: @user.id)
    end
  end

  def index
    @keyword = params[:keyword]
    @sort    = params[:sort]
    @users = User.where(is_active: true) # 退会済みユーザーは表示しない
    @users = @users.search_for(@keyword) if @keyword.present?
    @users = @sort == "latest" ? @users.latest : (@sort == "posts_count" ? @users.sort_by { |user| -user.posts.count } : @users.old)
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(18)
  end        # sort_byで取得したデータの場合に必要な、pageメソッドの配列レシーバ対応化

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.canonical_name), notice: I18n.t("users.update.notice")
    else
      flash.now[:alert] = I18n.t("users.update.alert")
      render :edit
    end
  end

  def insite
    @current_tab   = params[:current_tab]
    @required_data = params[:required_data]
    @rooms_participated_in = []
    @rooms_applying_for    = []
    true_participations  = Participation.where(user_id: @user.id, status: true)
    false_participations = Participation.where(user_id: @user.id, status: false)

    true_participations&.each do |participation|
      @rooms_participated_in << participation.counseling_room
    end
    false_participations&.each do |participation|
      @rooms_applying_for << participation.counseling_room
    end

    @data = @required_data == "opinions" ? @user.opinions : @user.posts

    @rooms_managing        = @user.counseling_rooms.page(params[:managing_rooms_page]).per(20)
    @rooms_participated_in = Kaminari.paginate_array(@rooms_participated_in).page(params[:participating_rooms_page]).per(20)
    @rooms_applying_for    = Kaminari.paginate_array(@rooms_applying_for).page(params[:applying_rooms_page]).per(20)
    @current_tab = "main_tab" unless @current_tab.present?
  end

  def withdraw
    @user.update(is_active: false)
    @user.posts.update_all(is_published: false) # 公開中の投稿全て非公開に変更
    reset_session
    redirect_to new_user_registration_path, notice: I18n.t("users.withdraw.notice")
  end

  def unsubscribe
  end

  private
    def user_params
      params.require(:user).permit(:last_name, :first_name, :public_name, :email, :position, :introduction, :profile_image)
    end

    def ensure_correct_user
      user = User.find_by(canonical_name: params[:canonical_name])      if params[:canonical_name]
      user = User.find_by(canonical_name: params[:user_canonical_name]) if params[:user_canonical_name]
      unless user == current_user
        redirect_to users_path, alert: I18n.t("users.incorrect_user.validates")
      end
    end

    def set_current_user
      @user = current_user
    end

    def ensure_active_page
      user = User.find_by(canonical_name: params[:canonical_name])
      if user.is_active == false
        redirect_to request.referer, alert: I18n.t("users.show.inactive_page")
      end
    end
end
