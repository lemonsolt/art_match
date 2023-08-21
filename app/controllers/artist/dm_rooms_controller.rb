class Artist::DmRoomsController < ApplicationController
  before_action :sign_in_user, {only: [:index]}
  before_action :ensure_guest_gallary,{only: [:index]}
  before_action :ensure_guest_artist,{only: [:index]}

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

  protected

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
