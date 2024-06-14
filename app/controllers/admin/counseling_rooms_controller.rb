class Admin::CounselingRoomsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @category = Category.find(params[:category_id])
    if params[:latest]                    #ソート切り替え(作成新しい順)
      @counseling_rooms = @category.counseling_rooms.latest
    elsif params[:old]                    #ソート切り替え(作成古い順)
      @counseling_rooms = @category.counseling_rooms.old
    elsif params[:participations_count]   #ソート切り替え(参加者人数順)
      counseling_rooms = @category.counseling_rooms.sort {|a,b| 
        b.participations.where(status: true).size <=> a.participations.where(status: true).size
      }
      @counseling_rooms = Kaminari.paginate_array(counseling_rooms)
    elsif params[:opinions_count]         #ソート切り替え(盛り上がり順/意見投稿の多い順)
      counseling_rooms = @category.counseling_rooms.sort {|a,b| 
        b.opinions.size <=> a.opinions.size
      }
      @counseling_rooms = Kaminari.paginate_array(counseling_rooms)
    elsif params[:content]                #同一カテゴリー内でのキーワード検索
      @counseling_rooms = CounselingRoom.search_with_category_for(params[:content], @category)
    else
      @counseling_rooms = @category.counseling_rooms
    end
    @counseling_rooms = @counseling_rooms.page(params[:page]).per(20)
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
    @tag_name = params[:tag_name]
    room_tag = RoomTag.find_by(name: @tag_name)
    if room_tag
      @counseling_rooms = room_tag.counseling_rooms.page(params[:page]).per(20)
    else
      @counseling_rooms = nil
    end
  end

end
