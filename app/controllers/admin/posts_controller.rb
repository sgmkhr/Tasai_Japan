class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
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
    elsif params[:tag_name]
      @posts = Post.search_with_tag_for(params[:tag_name]).page(params[:page]).per(12)
    elsif params[:content]
      @posts = Post.search_for(params[:content]).page(params[:page]).per(12)
    else
      @posts = Post.latest.page(params[:page]).per(12)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path, notice: I18n.t('posts.destroy.success')
  end
  
end
