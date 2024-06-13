class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
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
      @keyword = params[:content]
      @prefecture = params[:prefecture]
      @posts = Post.search_for(@keyword)
      if @posts && (@prefecture != 'unspecified')
        @posts = @posts.where(prefecture: @prefecture)
      end
    else
      @posts = Post.latest
    end
    @posts = @posts.page(params[:page]).per(12)
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
