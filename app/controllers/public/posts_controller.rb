class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,  only: [:new, :create]
  before_action :set_selected_post,  except: [:new, :index, :create]
  before_action :ensure_post_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts      = Post.includes(:post_tags)
    @keyword    = params[:keyword]
    @prefecture = params[:prefecture]
    @sort       = params[:sort]
    @tag_name   = params[:tag_name]
    if @tag_name.present?
      @posts = @posts.where('post_tags.name': @tag_name)
    else
      @posts = @posts&.latest if (@sort == 'latest') || (@sort.nil?)
      @posts = @posts&.old    if @sort == 'old'
      @posts = @posts&.where(prefecture: @prefecture) if @prefecture.present? && (@prefecture != 'unspecified')
      @posts = @posts&.search_for(@keyword) if @keyword.present?
      @posts = @posts&.includes(:post_favorites).sort_by { |post| -post.post_favorites.count } if @sort == 'favorites_count'
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end

  def show
    @comment = Comment.new
    unless PostView.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.post_views.create(post_id: @post.id) #閲覧カウント
    end
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
    params.require(:post).permit(:title, :caption, :body, :prefecture, :post_image)
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
