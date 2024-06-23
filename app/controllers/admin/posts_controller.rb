class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @keyword     = params[:keyword]
    @prefecture  = params[:prefecture]
    @sort        = params[:sort]
    @tag_name    = params[:tag_name]
    @current_tab = params[:current_tab]
    @posts = Post.where(is_published: true).includes(:post_tags)
    @tags  = PostTag.sort_by_popularity
    if @tag_name.present?
      @posts = @posts.where('post_tags.name': @tag_name)
    else
      @posts = @posts.search_for(@keyword)           if @keyword.present?
      @posts = @posts.where(prefecture: @prefecture) if @prefecture.present? && (@prefecture != 'unspecified')
      @posts = @sort == 'old' ? @posts.old : ( @sort == 'favorites_count' ? @posts&.sort_by { |post| -post.post_favorites.count } : @posts.latest )
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
    @current_tab = 'post_keyword_tab' unless @current_tab.present?
  end

  def show
    @post = Post.find(params[:id])
    redirect_to admin_posts_path, alert: I18n.t('posts.index.non_published') if @post.is_published == false
    @comment = Comment.new
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path, notice: I18n.t('posts.destroy.success')
  end
  
end
