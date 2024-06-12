class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:latest]     #ソート切り替え(新着順)
      @categories = Category.latest
    elsif params[:old]     #ソート切り替え(古い順)
      @categories = Category.old
    elsif params[:content] #キーワード検索
      @categories = Category.search_for(params[:content])
    else
      @categories = Category.all
    end
    @categories = @categories.page(params[:page]).per(30)
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to request.referer, notice: I18n.t('categories.destroy.success')
  end
  
end
