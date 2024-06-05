class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    # 非同期通信のためcomments/create.jsを呼び出す
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(params[:post_id])
    # 非同期通信のためcomments/destroy.jsを呼び出す
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
