class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:menu]
  
  def top
  end

  def about
  end

  def menu
  end
  
end
