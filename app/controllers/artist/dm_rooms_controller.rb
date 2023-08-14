class Artist::DmRoomsController < ApplicationController
  def index
    if artist_signed_in?
      @rooms = current_artist.dm_rooms.includes(:gallary)
    elsif gallary_signed_in?
      @rooms = current_gallary.dm_rooms.includes(:artist)
    end
  end
end
