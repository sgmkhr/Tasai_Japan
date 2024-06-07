class Admin::OpinionsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    Opinion.find(params[:id]).destroy
    @opinions = Opinion.all
    # 非同期通信のため、opinions/destroy.js.erbを呼び出す
  end
  
end
