class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Category.pade(params[:page]).per(30)
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_counseling_rooms_path(@category.id), notice: I18n.t('categories.create.succeeded')
    else
      flash.now[:alert] = I18n.t('categories.create.failed')
      render :index
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end
