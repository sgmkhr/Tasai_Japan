class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,  only: [:new, :create]
  before_action :set_selected_post,  except: [:new, :index, :create]
  before_action :ensure_post_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    if params[:latest]              #ソート切り替え(新着順)
      @posts = Post.latest
    elsif params[:old]              #ソート切り替え(古い順)
      @posts = Post.old
    elsif params[:favorites_count]  #ソート切り替え(いいね多い順)
      posts = Post.all.sort {|a,b| 
        b.post_favorites.size <=> a.post_favorites.size
      }
      @posts = Kaminari.paginate_array(posts)
    elsif params[:tag_name]         #タグ検索
      @tag_name = params[:tag_name]
      post_tag = PostTag.find_by(name: @tag_name)
      if post_tag
        @posts = post_tag.posts
      else
        return @posts = nil
      end
    elsif params[:content]          #キーワード検索
      @posts = Post.search_for(params[:content])
    else
      @posts = Post.latest
    end
    @posts = @posts.page(params[:page]).per(12)
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
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, alert: I18n.t('guestuser.validates')
    end
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
