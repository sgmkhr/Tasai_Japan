class Admin::CounselingRoomsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @category = Category.find(params[:category_id])
    @counseling_rooms = @category.counseling_rooms&.includes(:participations).includes(:opinions)
    @keyword = params[:keyword]
    @sort    = params[:sort]
    @counseling_rooms = @counseling_rooms.search_for(@keyword) if @keyword.present?
    @counseling_rooms = @counseling_rooms.latest if @sort == 'latest'
    @counseling_rooms = @counseling_rooms.old    if @sort == 'old'
    @counseling_rooms = @counseling_rooms.sort_by { |room| -room.participations.where(status: true).count } if @sort == 'participations_count'
    @counseling_rooms = @counseling_rooms.sort_by { |room| -room.opinions.count }       if @sort == 'opinions_count'
    @counseling_rooms = Kaminari.paginate_array(@counseling_rooms).page(params[:page]).per(20)
  end                   #sort_byで取得したデータの場合に必要な、pageメソッドの配列レシーバ対応化

  def show
    @category        = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:id])
    @participations  = @counseling_room.participations.where(status: true) #参加承認を受けているユーザーのみ表示
    @opinions        = @counseling_room.opinions
  end

  def destroy
    CounselingRoom.find(params[:id]).destroy
    redirect_to admin_category_counseling_rooms_path(params[:category_id]), notice: I18n.t('counseling_rooms.destroy')
  end
  
  def search
    @sort     = params[:sort]
    @keyword  = params[:keyword]
    @tag_name = params[:tag_name]
    @counseling_rooms = CounselingRoom.includes(:room_tags)
    @counseling_rooms = @counseling_rooms.search_for(@keyword) if @keyword.present?
    @counseling_rooms = @counseling_rooms.latest               if @sort == 'latest'
    @counseling_rooms = @counseling_rooms.old                  if @sort == 'old'
    @counseling_rooms = @counseling_rooms.where('room_tags.name': @tag_name) if @tag_name.present?
    @counseling_rooms = @counseling_rooms.page(params[:normal_page]).per(20)
  end

end
