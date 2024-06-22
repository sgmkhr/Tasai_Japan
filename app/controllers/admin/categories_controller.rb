class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @model   = params[:model]
    @keyword = params[:keyword]
    @sort    = params[:sort]
    @categories       = Category.all
    @counseling_rooms = CounselingRoom.all
    if @model == 'counseling_room'
      @counseling_rooms = @counseling_rooms.search_for(@keyword) if @keyword.present?
      @counseling_rooms = @sort == 'old' ? @counseling_rooms.old : @counseling_rooms.latest
      @counseling_rooms = @counseling_rooms.page(params[:normal_page]).per(20)
      render 'admin/counseling_rooms/search'
    end
    @categories = @categories.search_for(@keyword) if @keyword.present?
    @categories = @sort == 'old' ? @categories.old : @categories.latest
    @categories = @categories.page(params[:page]).per(30)
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to request.referer, notice: I18n.t('categories.destroy.success')
  end
  
end
