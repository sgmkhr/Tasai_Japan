class Admin::CounselingRoomsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @category = Category.find(params[:category_id])
    if params[:latest]
      @counseling_rooms = @category.counseling_rooms.latest.page(params[:page]).per(20)
    elsif params[:old]
      @counseling_rooms = @category.counseling_rooms.old.page(params[:page]).per(20)
    elsif params[:participations_count]
      counseling_rooms = @category.counseling_rooms.sort {|a,b| 
        b.participations.where(status: true).size <=> a.participations.where(status: true).size
      }
      @counseling_rooms = Kaminari.paginate_array(counseling_rooms).page(params[:page]).per(20)
    elsif params[:opinions_count]
      counseling_rooms = @category.counseling_rooms.sort {|a,b| 
        b.opinions.size <=> a.opinions.size
      }
      @counseling_rooms = Kaminari.paginate_array(counseling_rooms).page(params[:page]).per(20)
    elsif params[:content]
      @counseling_rooms = CounselingRoom.search_with_category_for(params[:content], @category).page(params[:page]).per(20)
    else
      @counseling_rooms = @category.counseling_rooms.page(params[:page]).per(20)
    end
  end

  def show
    @category = Category.find(params[:category_id])
    @counseling_room = CounselingRoom.find(params[:id])
    @participations = @counseling_room.participations.where(status: true) #参加承認を受けているユーザーのみ表示
    @opinions = Opinion.all
  end

  def destroy
    CounselingRoom.find(params[:id]).destroy
    redirect_to admin_category_counseling_rooms_path(params[:category_id]), notice: I18n.t('counseling_rooms.destroy')
  end

end
