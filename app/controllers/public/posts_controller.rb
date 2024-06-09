class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_selected_post,  except: [:new, :index, :create]
  before_action :ensure_post_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(12)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(12)
    elsif params[:favorites_count]
      posts = Post.all.sort {|a,b| 
        b.post_favorites.size <=> a.post_favorites.size
      }
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(12)
    elsif params[:content]
      @posts = Post.latest.search_for(params[:content]).page(params[:page]).per(12)
    else
      @posts = Post.latest.page(params[:page]).per(12)
    end
  end

  def show
    @comment = Comment.new
    unless PostView.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.post_views.create(post_id: @post.id)
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
