class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_selected_post, except: [:new, :index]
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
  end
  
  def create
    if @post.save(post_params)
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
    redirect_to posts_path, notice: I18n.t('posts.destroy')
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :caption, :body, :prefecture, :post_image)
  end
  
  def set_selected_post
    @user = User.find(params[:id])
  end
  
end
