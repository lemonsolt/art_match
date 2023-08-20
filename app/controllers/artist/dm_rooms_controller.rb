class Artist::DmRoomsController < ApplicationController
  before_action :authenticate_gallary! || :authenticate_artist!,{only: [:index]}
  before_action :ensure_guest_gallary,{only: [:index]}
  before_action :ensure_guest_artist,{only: [:index]}

  def index
    if artist_signed_in?
      artist = Artist.find(params[:id])
      unless artist.id == current_artist.id
        redirect_to root_path
      end
      @rooms = current_artist.dm_rooms.includes(:gallary)
      @unread_messages = []

      @rooms.each do |room|
        gallary = room.gallary
        unread_messages_in_artist = DmMessage.where(to_user_opentime: nil, gallary_id: gallary.id, artist_id: nil)
        @unread_messages.concat(unread_messages_in_artist)
      end
    elsif gallary_signed_in?
      gallary = Gallary.find(params[:id])
      unless gallary.id == current_gallary.id
        redirect_to root_path
      end
      @rooms = current_gallary.dm_rooms.includes(:artist)
      @unread_messages = []
      @rooms.each do |room|
        artist = room.artist
        unread_messages_in_gallary = DmMessage.where(to_user_opentime: nil, gallary_id: nil, artist_id: artist.id)
        @unread_messages.concat(unread_messages_in_gallary)
      end
    end
  end

  protected

  def ensure_guest_gallary
    @gallary = Gallary.find(params[:id])
    if @gallary.email == "guest@example.com"
      redirect_to gallary_path(current_gallary), alert: "ゲストギャラリーはDM画面へ遷移できません。"
    end
  end
  def ensure_guest_artist
    @artist = Artist.find(params[:id])
    if @artist.email == "guest@example.com"
      redirect_to gallary_path(current_artist), alert: "ゲストアーティストはDM画面へ遷移できません。"
    end
  end
end
