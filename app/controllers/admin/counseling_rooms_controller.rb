class Admin::CounselingRoomsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @category = Category.find(params[:category_id])
    @counseling_rooms = @category.counseling_rooms&.includes(:participations).includes(:opinions)
    @keyword = params[:keyword]
    @sort    = params[:sort]
    @counseling_rooms = @counseling_rooms.search_with_category_for(@keyword)
    @counseling_rooms = @counseling_rooms.latest if @sort == 'latest'
    @counseling_rooms = @counseling_rooms.old    if @sort == 'old'
    @counseling_rooms = @counseling_rooms.sort_by { |room| -room.participations.count } if @sort == 'participations_count'
    @counseling_rooms = @counseling_rooms.sort_by { |room| -room.opinions.count }       if @sort == 'opinions_count'
    @counseling_rooms = Kaminari.paginate_array(@counseling_rooms).page(params[:page]).per(20)
  end

  def show
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:id])
    @participations = @counseling_room.participations.where(status: true) #参加承認を受けているユーザーのみ表示
    @opinions = @counseling_room.opinions
  end

  def destroy
    CounselingRoom.find(params[:id]).destroy
    redirect_to admin_category_counseling_rooms_path(params[:category_id]), notice: I18n.t('counseling_rooms.destroy')
  end
  
  def search
    @tag_name   = params[:tag_name]
    @counseling_rooms = CounselingRoom.includes(:room_tags).where('room_tags.name': @tag_name).page(params[:page]).per(20)
  end

end
