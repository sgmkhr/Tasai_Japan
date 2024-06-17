class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @categories = Category.all
    @keyword    = params[:keyword]
    @sort       = params[:sort]
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
