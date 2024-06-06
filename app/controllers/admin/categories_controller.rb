class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @categories = Category.page(params[:page]).per(30)
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to admin_categories_path, notice: I18n.t('categories.destroy')
  end
  
end
