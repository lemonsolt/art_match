class Gallary::EventBookmarksController < ApplicationController
  before_action :authenticate_artist!,{only: [:show]}
  def show
    @artist = current_artist
    @bookmarks= EventBookmark.where(artist_id: @artist.id).order(created_at: :DESC).page(params[:page]).per(15)
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
