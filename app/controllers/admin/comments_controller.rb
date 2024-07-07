class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @post    = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    # 非同期通信のためcomments/destroy.jsを呼び出す
  end
end
