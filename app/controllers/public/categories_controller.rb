class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create]
  
  def index
    @category    = Category.new
    @categories  = Category.all
    @keyword     = params[:keyword]
    @sort        = params[:sort]
    @current_tab = params[:current_tab]
    @categories  = @categories.search_for(@keyword) if @keyword.present?
    @categories  = @categories.latest if @sort == 'latest'
    @categories  = @categories.old    if @sort == 'old'
    @categories  = @categories.page(params[:page]).per(30)
    @current_tab = 'category_create_tab' unless @current_tab.present?
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_counseling_rooms_path(@category.id), notice: I18n.t('categories.create.succeeded')
    else
      @categories = Category.page(params[:page]).per(30)
      flash.now[:alert] = I18n.t('categories.create.failed')
      render :index
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
end
