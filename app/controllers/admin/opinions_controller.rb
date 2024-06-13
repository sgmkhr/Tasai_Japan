class Admin::OpinionsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:counseling_room_id])
    Opinion.find(params[:id]).destroy
    @opinions = @counseling_room.opinions
    # 非同期通信のため、opinions/destroy.js.erbを呼び出す
  end
  
end
