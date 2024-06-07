class Public::ParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category_and_room, only: [:create, :destroy]
  before_action :ensure_room_creator,   only: [:update]
  
  def create
    @counseling_room.participations.create(user_id: current_user.id)
    @participation = current_user.participations.where(counseling_room_id: @counseling_room.id)
    # 非同期通信のため、participations/create.js.erbが呼び出される
  end
  
  def update
    participation = Participation.find(params[:id])
    participation.update(status: true)
    redirect_to request.referer, notice: I18n.t('participations.update')
  end
  
  def destroy
    participation = Participation.find(params[:id])
    if participation.user == current_user   #参加者による脱退の場合
      flash[:notice] = I18n.t('participations.destroy.by_participation')
    else                                    #作成者による参加却下の場合
      flash[:notice] = I18n.t('participations.destroy.by_creator')
    end
    participation.destroy
    redirect_to request.referer
  end
  
  private
  
  def set_category_and_room
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:counseling_room_id])
  end
  
  def ensure_room_creator
    unless current_user == Participation.find(params[:id]).counseling_room.user
      redirect_to request.referer, alert: I18n.t('counseling_rooms.ensure_creator')
    end
  end
  
end
