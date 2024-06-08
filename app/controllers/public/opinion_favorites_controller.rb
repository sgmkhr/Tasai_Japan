class Public::OpinionFavoritesController < ApplicationController
  before_action :authenticate_user!  
    
  def create
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:counseling_room_id])
    @opinion = Opinion.find(params[:opinion_id])
    current_user.opinion_favorites.create(opinion_id: @opinion.id)
    # 非同期通信のため、opinion_favorites/create.js.erbが呼び出される
  end
  
  def destroy
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:counseling_room_id])
    @opinion = Opinion.find(params[:opinion_id])
    current_user.opinion_favorites.find_by(opinion_id: @opinion.id).destroy
    # 非同期通信のため、opinion_favorites/destroy.js.erbが呼び出される
  end
  
end