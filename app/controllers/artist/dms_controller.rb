class Artist::DmsController < ApplicationController
  before_action :sign_in_user,{only: [:show]}
  before_action :ensure_guest_gallary,{only: [:show]}
  before_action :ensure_guest_artist,{only: [:show]}

  def show
    if artist_signed_in?
      @user = Gallary.find(params[:id])
      rooms = current_artist.dm_rooms.pluck(:id)
      user_rooms = DmRoom.where(gallary_id: @user.id, id: rooms)

      # ルームを再利用するか作るか
      if user_rooms.present?
        @room = user_rooms.last
      else
        @room = DmRoom.create(gallary_id: @user.id, artist_id: current_artist.id)
      end

      # DMの相手リストに必要な変数
      @rooms = current_artist.dm_rooms.includes(:gallary)
      @unread_messages = []

      @rooms.each do |room|
        gallary = room.gallary
        unread_messages_in_artist = DmMessage.where(to_user_opentime: nil, gallary_id: gallary.id, artist_id: nil)
        @unread_messages.concat(unread_messages_in_artist)
      end
      room_dm_messages = @room.dm_messages
      room_dm_messages.each do |message|
        if @unread_messages.include?(message)
          message.to_user_opentime = Date.today.to_time
          message.save
        end
      end

    elsif gallary_signed_in?
      @user = Artist.find(params[:id])
      rooms = current_gallary.dm_rooms.pluck(:id)
      user_rooms = DmRoom.where(artist_id: @user.id, id: rooms)

      if user_rooms.present?
        @room = user_rooms.last
      else
        @room = DmRoom.create(gallary_id: current_gallary.id, artist_id: @user.id)
      end

      # DMの相手リストに必要な変数
      @rooms = current_gallary.dm_rooms.includes(:artist)
      @unread_messages = []
      @rooms.each do |room|
        artist = room.artist
        unread_messages_in_gallary = DmMessage.where(to_user_opentime: nil, gallary_id: nil, artist_id: artist.id)
        @unread_messages.concat(unread_messages_in_gallary)
      end
      room_dm_messages = @room.dm_messages
      room_dm_messages.each do |message|
        if @unread_messages.include?(message)
          message.to_user_opentime = Date.today.to_time
          message.save
        end
      end

    end
    @messages = @room.dm_messages
    @message = DmMessage.new(dm_room_id: @room.id)
  end

  def create

    if artist_signed_in?
      @message = current_artist.dm_messages.new(message_params)
      @message.gallary_id = nil

    elsif gallary_signed_in?
      @message = current_gallary.dm_messages.new(message_params)
      @message.artist_id = nil
    end


    if @message.save
      @room = @message.dm_room
      @messages = @room.dm_messages
      # redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "メッセージの送信に失敗しました。"
      puts @message.errors.full_messages
      # redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @room = DmRoom.find(params[:id])
    @room.delete
    redirect_to dms_path, notice: "削除しました。"
  end

  private
  def room_params
    params.require(:dm_room).permit(:artist_id, :gallary_id, :dm_room_id)
  end
  def message_params
    params.require(:dm_message).permit(:message, :dm_room_id, :artist_id, :gallary_id)
  end

  def ensure_guest_gallary
    if gallary_signed_in? && current_gallary.email == "guest@example.com"
      redirect_to gallary_path(current_gallary), alert: "ゲストギャラリーはDM画面へ遷移できません。"
    end
  end
  def ensure_guest_artist
    if artist_signed_in? && current_artist.email == "guest@example.com"
      redirect_to gallary_path(current_artist), alert: "ゲストアーティストはDM画面へ遷移できません。"
    end
  end
  def sign_in_user
    unless artist_signed_in? || gallary_signed_in?
      redirect_to root_path, alert: "ログインしてください"
    end
  end
end
