class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create]
  
  def index
    if params[:latest]      #ソート切り替え(作成新しい順)
      @categories = Category.latest
    elsif params[:old]      #ソート切り替え(作成古い順)
      @categories = Category.old
    elsif params[:content]  #キーワード検索
      @categories = Category.search_for(params[:content])
    else
      @categories = Category.all
    end
    @categories = @categories.page(params[:page]).per(30)
    @category = Category.new
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
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, alert: I18n.t('guestuser.validates')
    end
  end
  
end
