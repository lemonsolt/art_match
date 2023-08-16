class Artist::DmRoomsController < ApplicationController
  def index
    if artist_signed_in?
      @rooms = current_artist.dm_rooms.includes(:gallary)
      @unread_messages = []
      
      @rooms.each do |room|
        gallary = room.gallary
        unread_messages_in_artist = DmMessage.where(to_user_opentime: nil, gallary_id: gallary.id, artist_id: nil)
        @unread_messages.concat(unread_messages_in_artist)
      end
    elsif gallary_signed_in?
      @rooms = current_gallary.dm_rooms.includes(:artist)
      @unread_messages = []
      @rooms.each do |room|
        artist = room.artist
        unread_messages_in_gallary = DmMessage.where(to_user_opentime: nil, gallary_id: nil, artist_id: artist.id)
        @unread_messages.concat(unread_messages_in_gallary)
      end
    end
  end
end
