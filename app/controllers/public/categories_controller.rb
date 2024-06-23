class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create]
  
  def index
    @model       = params[:model]
    @keyword     = params[:keyword]
    @sort        = params[:sort]
    @current_tab = params[:current_tab]
    @category         = Category.new
    @categories       = Category.all
    @counseling_rooms = CounselingRoom.all
    @tags = RoomTag.sort_by_popularity
    if @model == 'counseling_room'
      @counseling_rooms = @counseling_rooms.search_for(@keyword) if @keyword.present?
      @counseling_rooms = @sort == 'old' ? @counseling_rooms.old : @counseling_rooms.latest
      @counseling_rooms = @counseling_rooms.old.page(params[:normal_page]).per(20)
      render 'public/counseling_rooms/search'#検索対象が相談室の場合のみsearch画面へ遷移
    end
    @categories = @categories.search_for(@keyword) if @keyword.present?
    @categories = @sort == 'old' ? @categories.old : @categories.latest
    @categories = @categories.page(params[:page]).per(12)
    @current_tab = 'category_create_tab' unless @current_tab.present?
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_counseling_rooms_path(@category.id), notice: I18n.t('categories.create.succeeded')
    else
      @categories = Category.latest.page(params[:page]).per(12)
      @tags = RoomTag.sort_by_popularity
      @current_tab = 'category_create_tab' unless @current_tab.present?
      flash.now[:alert] = I18n.t('categories.create.failed')
      render :index
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end
