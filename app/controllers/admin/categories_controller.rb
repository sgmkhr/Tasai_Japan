class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @categories = Category.page(params[:page]).per(30)
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to request.referer, notice: I18n.t('categories.destroy.success')
  end
  
end
