class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_selected_post,  except: [:new, :index, :create]
  before_action :ensure_post_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page]).per(12)
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: I18n.t('posts.create.notice')
    else
      flash.now[:alert] = I18n.t('posts.create.alert')
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
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
