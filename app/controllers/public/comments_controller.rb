class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  before_action :ensure_comment_author_and_set_comment, only: [:destroy]

  def create
    @post    = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    render :validator unless @comment.save
    # 非同期通信のためcomments/create.jsを呼び出す
  end

  def destroy
    @comment.destroy
    # 非同期通信のためcomments/destroy.jsを呼び出す
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def ensure_comment_author_and_set_comment
      @comment = Comment.find(params[:id])
      @post    = Post.find(params[:post_id])
      unless @comment.user == current_user
        redirect_to post_path(@post.id), alert: I18n.t("comments.validates")
      end
    end
end
