class Artist::DmsController < ApplicationController
  def index
    if artist_signed_in?
      @rooms = current_artist.dm_rooms
    elsif gallary_signed_in?
      @rooms = current_gallary.dm_rooms
    end
  end

  def show
    # 別コントローラだと不安だったためif文でまとめてここに表記
    if artist_signed_in?
      @user = Gallary.find(params[:id])
      rooms = current_artist.dm_rooms.pluck(:dm_room_id)
      user_rooms = DmRoom.find_by(gallary_id: @user.id, id: rooms )

      unless user_rooms.nil? # roomが無かったら作りあったらそれを見つけ表示
        @room = user_rooms
      else
        @room = DmRoom.new(gallary: @user, artist: current_artist)
        @room.save
      end
    elsif gallary_signed_in?
      @user = Artist.find(params[:id])
      rooms = current_gallary.dm_rooms.pluck(:dm_room_id)
      user_rooms = DmRoom.find_by(artist_id: @user.id, id: rooms )

      unless user_rooms.nil?
        @room = user_rooms
      else
        @room = DmRoom.new(gallary: current_gallary, artist: @user)
        @room.save
      end
    end
    @messages = @room.dm_messages
    @message = DmMessage.new(dm_room_id: @room.id)
  end

  def create
    if artist_signed_in?
      @message = current_artist.dm_messages.new(artist_message_params)
    elsif gallary_signed_in?
      @message = current_gallary.dm_messages.new(gallary_message_params)
    end
    if @message.save
      @room = @message.dm_room
      @messages = @room.dm_messages
    else
      flash[:alert] = "メッセージの送信に失敗しました。"
    end

  end

  def destroy
    @room = DmRoom.find(params[:id])
    @room.delete
    redirect_to dms_path, notice: "削除しました。"
  end

  private
  def room_params
    params.require(:dm_room).permit(:artist_id, :gallary_id)
  end
  def artist_message_params
    params.require(:dm_message).permit(:artist_id,:message, :dm_room_id)
  end
  def gallary_message_params
    params.require(:dm_message).permit(:gallary_id,:message, :dm_room_id)
  end
end
