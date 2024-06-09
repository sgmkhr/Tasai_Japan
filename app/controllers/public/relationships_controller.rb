class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_set_approached_user
  
  def create
    current_user.follow(@user)
    # 非同期通信のため、relationships/create.js.erbを呼び出す
  end
  
  def destroy
    current_user.unfollow(@user)
    # 非同期通信のため、relationships/destroy.js.erbを呼び出す
  end
  
  def followings
    @users = @user.followings
  end
  
  def followers
    @users = @user.followers
  end
  
  private
  
  def set_approached_user
    @user = User.find_by(canonical_name: params[:canonical_name])
  end
  
end
