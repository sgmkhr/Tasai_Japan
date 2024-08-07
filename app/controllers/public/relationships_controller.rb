class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create, :destroy]
  before_action :set_approached_user

  def create
    current_user.follow(@user)
    # 非同期通信のため、relationships/create.js.erbを呼び出す
  end

  def destroy
    current_user.unfollow(@user)
    # 非同期通信のため、relationships/destroy.js.erbを呼び出す
  end

  def followings
    @users = @user.followings.where(is_active: true).page(params[:page]).per(18)
  end

  def followers
    @users = @user.followers.where(is_active: true).page(params[:page]).per(18)
  end

  private
    def set_approached_user
      @user = User.find_by(canonical_name: params[:user_canonical_name])
    end
end
