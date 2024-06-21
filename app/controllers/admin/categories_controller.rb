class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @categories = Category.all
    @keyword    = params[:keyword]
    @sort       = params[:sort]
    @model      = params[:model]
    @counseling_rooms = CounselingRoom.all
    if @model == 'counseling_room'
      @counseling_rooms = @counseling_rooms.search_for(@keyword) if @keyword.present?
      @counseling_rooms = @counseling_rooms.latest.page(params[:normal_page]).per(20) if @sort == 'latest'
      @counseling_rooms = @counseling_rooms.old.page(params[:normal_page]).per(20)    if @sort == 'old'
      render 'admin/counseling_rooms/search'
    end
    @categories = @categories.search_for(@keyword) if @keyword.present?
    @categories = @categories.latest if @sort == 'latest'
    @categories = @categories.old    if @sort == 'old'
    @categories = @categories.page(params[:page]).per(30)
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to request.referer, notice: I18n.t('categories.destroy.success')
  end
  
end
