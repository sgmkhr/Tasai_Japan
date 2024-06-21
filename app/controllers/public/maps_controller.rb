class Public::MapsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @post = Post.find(params[:post_id])
  end

  def index
  end
end
