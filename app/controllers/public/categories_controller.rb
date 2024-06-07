class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if params[:content]
      @categories = Category.search_for(params[:content]).page(params[:page]).per(30)
    else
      @categories = Category.page(params[:page]).per(30)
    end
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
