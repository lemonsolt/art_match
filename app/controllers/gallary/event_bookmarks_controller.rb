class Gallary::EventBookmarksController < ApplicationController
  before_action :authenticate_artist!,{only: [:show]}
  def show
    artist = Artist.find(params[:id])
    unless artist.id == current_artist.id
      redirect_to root_path
    end
    @artist = current_artist
    @bookmarks= EventBookmark.where(artist_id: @artist.id)
  end

  def create
    @event = GallaryEvent.find(params[:event_id])
    @event_bookmark = current_artist.event_bookmarks.create(gallary_event_id: @event.id)
    @event_bookmark.save
  end

  def destroy
    @event = GallaryEvent.find(params[:event_id])
    @event_bookmark = current_artist.event_bookmarks.find_by(gallary_event_id: @event.id)
    @event_bookmark.destroy
  end
end
