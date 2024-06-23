class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,  only: [:new, :create]
  before_action :set_selected_post,  except: [:new, :index, :create]
  before_action :ensure_post_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @keyword     = params[:keyword]
    @prefecture  = params[:prefecture]
    @sort        = params[:sort]
    @tag_name    = params[:tag_name]
    @current_tab = params[:current_tab]
    @posts = Post.where(is_published: true).includes(:post_tags).includes(:post_favorites)
    @tags  = PostTag.sort_by_popularity
    if @tag_name.present?
      @posts = @posts.where('post_tags.name': @tag_name)
    else
      @posts = @posts.search_for(@keyword)           if @keyword.present?
      @posts = @posts.where(prefecture: @prefecture) if @prefecture.present? && (@prefecture != 'unspecified')
      @posts = @sort == 'old' ? @posts.old : ( @sort == 'favorites_count' ? @posts&.sort_by { |post| -post.post_favorites.count } : @posts.latest )
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:normal_page]).per(12)
    @current_tab = 'post_keyword_tab' unless @current_tab.present?
  end

  def show
    if (@post.is_published == false) && (@post.user != current_user)
      redirect_to posts_path, alert: I18n.t('posts.index.non_published')
    end
    unless PostView.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.post_views.create(post_id: @post.id) #閲覧カウント
    end
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_name_list = params[:post][:tag_name].split('/')
    if @post.save
      @post.save_tags(tag_name_list)
      redirect_to post_path(@post.id), notice: I18n.t('posts.create.notice')
    else
      flash.now[:alert] = I18n.t('posts.create.alert')
      render :new
    end
  end

  def edit
  end

  def update
    tag_name_list = params[:post][:tag_name].split('/')
    if @post.update(post_params)
      @post.save_tags(tag_name_list)
      redirect_to post_path(@post.id), notice: I18n.t('posts.update.notice')
    else
      flash.now[:alert] = I18n.t('posts.update.alert')
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@post.user.canonical_name), notice: I18n.t('posts.destroy.success')
  end

  private

  def post_params
    params.require(:post).permit(:title, :caption, :body, :prefecture, :post_image, :is_published, :address)
  end

  def set_selected_post
    @post = Post.find(params[:id])
  end

  def ensure_post_author
    unless @post.user == current_user
      redirect_to post_path(@post.id), alert: I18n.t('posts.validates')
    end
  end

end
