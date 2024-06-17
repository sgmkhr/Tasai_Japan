class Public::CounselingRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user,   only: [:new, :create]
  before_action :set_category,        except: [:search]
  before_action :ensure_room_creator, only: [:edit, :update, :destroy]

  def index
    if params[:latest]                    #ソート切り替え(作成新しい順)
      @counseling_rooms = @category.counseling_rooms.latest
    elsif params[:old]                    #ソート切り替え(作成古い順)
      @counseling_rooms = @category.counseling_rooms.old
    elsif params[:participations_count]   #ソート切り替え(参加者多い数)
      counseling_rooms = @category.counseling_rooms.sort {|a,b|
        b.participations.where(status: true).size <=> a.participations.where(status: true).size
      }
      @counseling_rooms = Kaminari.paginate_array(counseling_rooms)
    elsif params[:opinions_count]         #ソート切り替え(意見多い順)
      counseling_rooms = @category.counseling_rooms.sort {|a,b|
        b.opinions.size <=> a.opinions.size
      }
      @counseling_rooms = Kaminari.paginate_array(counseling_rooms)
    elsif params[:content]                #キーワード検索
      @counseling_rooms = CounselingRoom.search_with_category_for(params[:content], @category)
    else
      @counseling_rooms = @category.counseling_rooms
    end
    @counseling_rooms = @counseling_rooms.page(params[:page]).per(20)
  end

  def new
    @counseling_room = CounselingRoom.new
  end

  def create
    @counseling_room = CounselingRoom.new(counseling_room_params)
    @counseling_room.category_id = @category.id
    @counseling_room.user_id = current_user.id
    tag_name_list = params[:counseling_room][:tag_name].split('/')
    if @counseling_room.save
      @counseling_room.save_tags(tag_name_list)
      redirect_to category_counseling_room_path(@category.id, @counseling_room.id), notice: I18n.t('counseling_rooms.create.succeeded')
    else
      flash.now[:alert] = I18n.t('counseling_rooms.create.failed')
      render :new
    end
  end

  def show
    @counseling_room = CounselingRoom.find(params[:id])
    @participations = @counseling_room.participations.where(status: true) #参加承認を受けているユーザーのみ表示
    @participation = current_user.participations.find_by(counseling_room_id: @counseling_room.id)
    @opinion = Opinion.new
    @opinions = @counseling_room.opinions
  end

  def edit
    @counseling_room = CounselingRoom.find(params[:id])
    @active_participations  = @counseling_room.participations.where(status: true).page(params[:page]).per(10)
    @waiting_participations = @counseling_room.participations.where(status: false).page(params[:page]).per(10)
  end

  def update
    @counseling_room = CounselingRoom.find(params[:id])
    tag_name_list = params[:counseling_room][:tag_name].split('/')
    if @counseling_room.update(counseling_room_params)
      @counseling_room.save_tags(tag_name_list)
      redirect_to category_counseling_room_path(@category.id, @counseling_room.id), notice: I18n.t('counseling_rooms.update.succeeded')
    else
      flash.now[:alert] = I18n.t('counseling_rooms.update.failed')
      render :edit
    end
  end

  def destroy
    CounselingRoom.find(params[:id]).destroy
    redirect_to category_counseling_rooms_path(@category.id), notice: I18n.t('counseling_rooms.destroy')
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

  private

  def counseling_room_params
    params.require(:counseling_room).permit(:topic, :detail, :topic_image)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def ensure_room_creator
    counseling_room = CounselingRoom.find(params[:id])
    unless current_user == counseling_room.user
      redirect_to category_counseling_room_path(@category.id, counseling_room.id), notice: I18n.t('counseling_rooms.ensure_creator')
    end
  end

end
