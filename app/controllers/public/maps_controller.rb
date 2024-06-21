class Public::MapsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    respond_to do |format|
      format.html do
        @post = Post.find(params[:post_id])
      end
      format.json do
        @post = Post.find(params[:post_id])
      end
    end
  end

  def index
    respond_to do |format|
      format.html do
        @posts = Post.where(is_published: true)&.page(params[:page])
      end
      format.json do
        @posts = Post.where(is_published: true)
      end
    end
  end
end
