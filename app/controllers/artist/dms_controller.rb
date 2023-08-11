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
      rooms = current_artist.dm_rooms.pluck(:room_id)
      user_rooms = DmRoom.find_by(gallary_id: @user.id, room_id: rooms )

      unless user_rooms.nil? # roomが無かったら作りあったらそれを見つけ表示
        @room = user_rooms
      else
        @room = DmRoom.new
        @room.save(gallary_id: @user.id,aritst_id: current_artist, room_id: @room.id)
      end
    elsif gallary_signed_in?
      @user = Artist.find(params[:id])
      rooms = current_gallary.dm_rooms.pluck(:room_id)
      user_rooms = DmRoom.find_by(artist_id: @user.id, room_id: rooms )

      unless user_rooms.nil?
        @room = user_rooms
      else
        @room = DmRoom.new
        @room.save(gallary_id: current_gallary, aritst_id: @user.id,room_id: @room.id)
      end
    end
    @messages = @room.dm_messages
    @message = DmMessage.new(room_id: @room.id)
  end

  def create
    if artist_signed_in?
      @message = current_artist.dm_messages.new(message_params)
      @room = @message.dm_room
      @messages = @room.dm_messages
      render :validater unless @message.save
    elsif gallary_signed_in?
      @message = current_gallary.dm_messages.new(message_params)
      @room = @message.dm_room
      @messages = @room.dm_messages
      render :validater unless @message.save
    end

  end

  def destroy
    @room = DmRoom.find(params[:id])
    @room.delete
    redirect_to dms_path, notice: "削除しました。"
  end

  private
  def room_params
    params.require(:dm_room).permit(:artist_id, :gallary_id, :room_id)
  end
  def message_params
    params.require(:dm_message).permit(:artist_id, :gallary_id, :message, :room_id)
  end
end
