class Public::MapsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def index
    @posts = Post.where(is_published: true)
    respond_to do |format|
      format.html
      format.json
    end
  end
  
end
