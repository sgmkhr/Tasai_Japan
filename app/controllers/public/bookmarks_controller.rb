class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  
  def create
    @post = Post.find(params[:post_id])
    current_user.bookmarks.create(post_id: @post.id)
    # 非同期通信のため、bookmarks/create.js.erbを呼び出す
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    current_user.bookmarks.find_by(post_id: @post.id).destroy
    # 非同期通信のため、bookmarks/destroy.js.erbを呼び出す
  end
  
end
