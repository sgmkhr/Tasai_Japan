class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:content]
      @posts = Post.search_for(params[:content]).page(params[:page]).per(12)
    else
      @posts = Post.page(params[:page]).per(12)
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
