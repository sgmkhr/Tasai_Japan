class Public::CommentFavoritesController < ApplicationController
  before_action :authenticate_user!  
  before_action :ensure_guest_user
    
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    current_user.comment_favorites.create(comment_id: @comment.id)
    # 非同期通信のため、comment_favorites/create.js.erbが呼び出される
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    current_user.comment_favorites.find_by(comment_id: @comment.id).destroy
    # 非同期通信のため、comment_favorites/destroy.js.erbが呼び出される
  end
  
  private
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, alert: I18n.t('guestuser.validates')
    end
  end
  
end
