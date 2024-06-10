class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  
  def followings
    user = User.find_by(canonical_name: params[:user_canonical_name])
    @users = user.followings.where(is_active: true).page(params[:page]).per(18)
  end
  
  def followers
    user = User.find_by(canonical_name: params[:user_canonical_name])
    @users = user.followers.where(is_active: true).page(params[:page]).per(18)
  end
  
end
