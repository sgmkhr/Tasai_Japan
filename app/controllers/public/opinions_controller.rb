class Public::OpinionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @opinion = current_user.opinions.new(opinion_params)
    @opinion.counseling_room_id = CounselingRoom.find(params)
    @opinion.save
    @opinions = Opinion.all
    # 非同期通信のため、opinions/create.js.erbを呼び出す
  end
  
  def destroy
    Opinion.find(params[:id]).destroy
    @opinions = Opinion.all
    # 非同期通信のため、opinions/destroy.js.erbを呼び出す
  end
  
  private
  
  def opinion_params
    params.require(:opinion).permit(:content)
  end
  
end
