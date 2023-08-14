class Artist::DmsController < ApplicationController
  def index
    if artist_signed_in?
      @rooms = current_artist.dm_rooms
    elsif gallary_signed_in?
      @rooms = current_gallary.dm_rooms
    end
  end

  def show
    if artist_signed_in?
      @user = Gallary.find(params[:id])
      rooms = current_artist.dm_rooms.pluck(:id)
      user_rooms = DmRoom.where(gallary_id: @user.id, id: rooms)

      if user_rooms.present?
        @room = user_rooms.last
      else
        @room = DmRoom.create(gallary_id: @user.id, artist_id: current_artist.id)
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
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "メッセージの送信に失敗しました。"
      puts @message.errors.full_messages
      redirect_back(fallback_location: root_path)
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
end
