class Gallary::EventBookmarksController < ApplicationController
  def bookmark_index
    @event_bookmarks = current_artist.event_bookmarks.all
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
