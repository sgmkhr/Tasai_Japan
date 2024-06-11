class Public::OpinionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  before_action :set_category_and_room
  
  def create
    @opinion = current_user.opinions.new(opinion_params)
    @opinion.counseling_room_id = @counseling_room.id
    @opinions = Opinion.all
    render :validator unless @opinion.save
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
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, alert: I18n.t('guestuser.validates')
    end
  end
  
  def set_category_and_room
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:counseling_room_id])
  end
  
end
