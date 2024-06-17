class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts      = Post.includes(:post_tags).includes(:post_favorites)
    @keyword    = params[:keyword]
    @prefecture = params[:prefecture]
    @sort       = params[:sort]
    @tag_name   = params[:tag_name]
    if @tag_name.present?
      @posts = @posts.where('post_tags.name': @tag_name)
    else
      @posts = @posts.search_for(@keyword)           if @keyword.present?
      @posts = @posts.where(prefecture: @prefecture) if @prefecture.present? && (@prefecture != 'unspecified')
      @posts = @posts.latest                         if (@sort == 'latest') || (@sort.nil?)
      @posts = @posts.old                            if @sort == 'old'
      @posts = @posts.sort_by { |post| -post.post_favorites.count } if @sort == 'favorites_count'
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
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
