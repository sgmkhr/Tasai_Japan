class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  before_action :ensure_permitted_user, only: [:index]
  before_action :reject_non_related,    only: [:show]
  
  def index
    @entries = current_user.entries
  end

  def show
    @user = User.find(params[:id])
    room_ids = current_user.entries.pluck(:chat_room_id)
    entry = Entry.find_by(user_id: @user.id, chat_room_id: room_ids)
    unless entries.nil?
      @room = entry.chat_room
    else
      @room = ChatRoom.new
      @room.save
      Entry.create(user_id: current_user.id, chat_room_id: @room.id)
      Entry.create(user_id: @user.id, chat_room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    render :validator unless @chat.save
    # 非同期通信のため、chats/create.js.erbを呼び出す
  end
  
  def destroy
    Chat.find(params[:id]).destroy
    # 非同期通信のため、chats/destroy.js.erbを呼び出す
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:content, :chat_room_id)
  end
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, alert: I18n.t('guestuser.validates')
    end
  end
  
  def ensure_permitted_user
    user = User.find_by(canonical_name: params[:user_canonical_name])
    unless user.id == current_user.id
      redirect_to request.referer, alert: I18n.t('chats.validates.non_permitted')
    end
  end
  
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to request.referer, alert: I18n.t('chats.validates.non_related')
    end
  end
  
end
